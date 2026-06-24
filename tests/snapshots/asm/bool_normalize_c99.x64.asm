
bool_normalize_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ret_bool>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<take_bool>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %esi
               	movl	%esi, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	andq	$0xff, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	xorq	%rdi, %rdi
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	andq	$0xff, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	andq	$0xff, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x1, %edi
               	movb	%dil, (%rsi)
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x7, %edi
               	movl	%edi, 0x4(%rsi)
               	leaq	-0x58(%rbp), %rsi
               	xorq	%rdi, %rdi
               	movb	%dil, 0x8(%rsi)
               	leaq	-0x58(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movslq	0x4(%rsi), %rsi
               	cmpq	$0x7, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movzbq	0x8(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %esi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	andq	$0xff, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rsi
               	xorq	%rdi, %rdi
               	movl	$0x1, %r9d
               	movb	%r9b, (%rsi)
               	leaq	-0x60(%rbp), %rsi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x60(%rbp), %rsi
               	movb	%r9b, 0x2(%rsi)
               	leaq	-0x60(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x1, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x60(%rbp), %rsi
               	movzbq	0x1(%rsi), %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	leaq	-0x60(%rbp), %rsi
               	movzbq	0x2(%rsi), %rsi
               	cmpq	$0x1, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	$0xff, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
