
vector_object_alignment.x64:	file format elf64-x86-64

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

<automatic_objects>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movb	$0x1, -0x30(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movb	$0x2, -0x20(%rbp)
               	leaq	0x20(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x3, -0x18(%rbp)
               	leaq	(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movb	$0x4, -0x10(%rbp)
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movb	$0x5, -0x8(%rbp)
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%r8), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	leaq	0x50(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	movsbq	-0x30(%rbp), %rax
               	movsbq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	%dil, %rdi
               	leaq	0x20(%rsp), %rax
               	movups	%xmm0, 0x20(%rsp)
               	leaq	(%rsp), %rcx
               	vmovups	%ymm1, (%rsp)
               	movb	%dil, -0x30(%rbp)
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x25, %eax
               	vzeroupper
               	leave
               	retq
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x26, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x27, %eax
               	vzeroupper
               	leave
               	retq
               	movsbq	-0x30(%rbp), %rax
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x48(%rsp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x17, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0x1f, %al
               	jne	<addr>
               	addq	$0x20, %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	jne	<addr>
               	addq	$0x10, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	movl	$0x4, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0xf, %cl
               	jne	<addr>
               	leaq	0x10(%rcx), %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	jne	<addr>
               	leaq	0x10(%rax), %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	subq	%rcx, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	leaq	0x20(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movw	$0x3, <rip> # <addr>
               	movl	$0x5, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0xd, <rip> # <addr>
               	movswq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
