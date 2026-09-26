
const_strlen_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rsi
               	leaq	-0x48(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax      # <addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movq	%rsp, %rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movb	$0x78, (%rax)
               	movb	$0x0, 0x1(%rax)
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rsp
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	addq	$0x4, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsbq	0x1c(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	addq	$0x4, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	0x20(%rax), %ecx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsbq	0x3c(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	addq	$0x24, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
