
static_init_once_guard.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<step>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax
               	movsbq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %ecx
               	movb	%cl, 0x10(%rax)
               	movq	%rcx, -0x8(%rbp)
               	movslq	0x10(%rbp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rax), %rax
               	jmpq	*%rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rax
               	jmpq	*%rax

<flag_table>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	<rip>, %rax
               	movsbq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, (%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0x8(%rax)
               	movb	%dl, 0x10(%rax)
               	jmp	<addr>
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	movslq	(%rax,%rdi,4), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
