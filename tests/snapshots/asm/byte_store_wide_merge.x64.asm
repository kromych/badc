
byte_store_wide_merge.x64:	file format elf64-x86-64

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

<store_be32>:
               	xorq	%rax, %rax
               	movl	%esi, %ecx
               	bswapl	%ecx
               	movl	%ecx, (%rdi)
               	retq

<store_le32>:
               	xorq	%rax, %rax
               	movl	%esi, (%rdi)
               	retq

<store_be64>:
               	movq	%rsi, %rcx
               	bswapq	%rcx
               	movq	%rcx, (%rdi)
               	xorq	%rax, %rax
               	retq

<store_le16>:
               	xorq	%rax, %rax
               	movw	%si, (%rdi)
               	retq

<store_be24>:
               	xorq	%rax, %rax
               	movl	%esi, %ecx
               	shrq	$0x10, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movl	%esi, %ecx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x1(%rdi)
               	movl	%esi, %ecx
               	andq	$0xff, %rcx
               	movb	%cl, 0x2(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x44332211, %ecx       # imm = 0x44332211
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x9, %rax
               	movl	$0xddccbbaa, %ecx       # imm = 0xDDCCBBAA
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x9(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	movabsq	$0x102030405060708, %rsi # imm = 0x102030405060708
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x1(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x8, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0xb, %rax
               	movl	$0xfeed, %ecx           # imm = 0xFEED
               	movw	%cx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0xb(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x2, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0xd, %rax
               	movl	$0x77, %ecx
               	movb	%cl, (%rax)
               	movl	$0x88, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x99, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0xd(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x3, %rcx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x11, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xaa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
