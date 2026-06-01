
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	%edx, %r8
               	leaq	<rip>, %rdi
               	movq	%r11, %rsi
               	movq	%r8, %rcx
               	movq	%r9, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x7, %ebx
               	cmpq	$0x7, %rbx
               	jne	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x28(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x13, %edx
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x8, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x14, %edx
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
