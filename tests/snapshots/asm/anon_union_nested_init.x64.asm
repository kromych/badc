
anon_union_nested_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_const>:
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x58, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x42, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x28(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x38(%rax), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	0x48(%rax), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	0x4c(%rax), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x58(%rax), %rax
               	cmpq	$0x1e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x40(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x74, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movb	%dil, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movb	%sil, 0x1(%rax)
               	leaq	(%rdi,%rsi), %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x2(%rcx)
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x3(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x3(%rax), %rcx
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	$0x9, %eax
               	leaq	-0x18(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x8, %ecx
               	leaq	-0x18(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x18(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x18(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
