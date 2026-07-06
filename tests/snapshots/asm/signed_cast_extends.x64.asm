
signed_cast_extends.x64:	file format elf64-x86-64

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
               	subq	$0xd0, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x8, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x9, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xa, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xb, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movl	$0xff, %ecx
               	movb	%cl, (%rax)
               	leaq	-0xb8(%rbp), %rax
               	movl	$0x42, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0xb8(%rbp), %rax
               	movl	$0x10, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	shlq	$0x8, %rax
               	leaq	-0xb8(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0xbe, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
