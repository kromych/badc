
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
               	xorq	%rcx, %rcx
               	movl	%esi, %eax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rdi)
               	andq	$0xff, %rax
               	movb	%al, 0x2(%rdi)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movl	$0x44332211, %ecx       # imm = 0x44332211
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rdx
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0x9(%rax), %rdx
               	movl	$0xddccbbaa, %ecx       # imm = 0xDDCCBBAA
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	leaq	0x1(%r12), %rbx
               	movabsq	$0x102030405060708, %rsi # imm = 0x102030405060708
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rbx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x8, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0xb(%rax), %rdx
               	movl	$0xfeed, %ecx           # imm = 0xFEED
               	movw	%cx, (%rdx)
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0xd(%rax), %rdx
               	movl	$0x77, %ecx
               	movb	%cl, (%rdx)
               	movl	$0x88, %ecx
               	movb	%cl, 0x1(%rdx)
               	movl	$0x99, %ecx
               	movb	%cl, 0x2(%rdx)
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x11, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0xaa, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
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
