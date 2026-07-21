
inline_asm_const_modifier.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<get_seven>:
               	movl	$0x7, %eax
               	retq

<read_directive_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x2a, %edx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movq	-0x30(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x28(%rbp), %r11
               	movl	%ebx, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<address_modifier>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x28(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<call_modifier>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %r11
               	callq	*%r11
               	movq	-0x28(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x2a, %edx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movq	-0x70(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x68(%rbp), %r11
               	movl	%ebx, (%r11)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rax, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	-0x78(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x80(%rbp), %rax
               	movq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	%rdi, -0x60(%rbp)
               	movq	%r8, -0x58(%rbp)
               	movq	%r9, -0x50(%rbp)
               	movq	%r10, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %r11
               	callq	*%r11
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rsi
               	movq	-0x60(%rbp), %rdi
               	movq	-0x58(%rbp), %r8
               	movq	-0x50(%rbp), %r9
               	movq	-0x48(%rbp), %r10
               	movq	-0x40(%rbp), %r11
               	movq	-0x20(%rbp), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
