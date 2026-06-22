
errno_socket_constants.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rcx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rcx), %r11
               	movq	%r11, 0x38(%rax)
               	popq	%r11
               	movl	$0x40, %eax
               	xorq	%rdx, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	movslq	%edx, %rcx
               	movslq	%eax, %rsi
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movslq	%edx, %rsi
               	movslq	(%rcx,%rsi,4), %rcx
               	testq	%rcx, %rcx
               	jg	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rsi
               	movslq	%esi, %rcx
               	movslq	%eax, %rdi
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rcx
               	movq	%rcx, %rsi
               	incq	%rsi
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movslq	%edx, %rdi
               	movslq	(%rcx,%rdi,4), %rcx
               	leaq	-0x40(%rbp), %rdi
               	movslq	%esi, %r8
               	movslq	(%rdi,%r8,4), %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
