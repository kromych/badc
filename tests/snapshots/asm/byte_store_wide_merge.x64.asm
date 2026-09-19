
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
               	movl	%esi, %eax
               	bswapl	%eax
               	movl	%eax, (%rdi)
               	retq

<store_le32>:
               	movl	%esi, (%rdi)
               	retq

<store_be64>:
               	movq	%rsi, %rcx
               	bswapq	%rcx
               	movq	%rcx, (%rdi)
               	retq

<store_le16>:
               	movw	%si, (%rdi)
               	retq

<store_be24>:
               	movl	%esi, %eax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x1(%rdi)
               	andq	$0xff, %rax
               	movb	%al, 0x2(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movl	$0x44332211, %ecx       # imm = 0x44332211
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rsi
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, 0x4(%rax)
               	leaq	0x4(%rax), %rdx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x9(%rax), %rdx
               	movl	$0xddccbbaa, %ecx       # imm = 0xDDCCBBAA
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x1(%rax), %rdx
               	movabsq	$0x807060504030201, %rcx # imm = 0x807060504030201
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x8, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0xb(%rax), %rdx
               	movl	$0xfeed, %ecx           # imm = 0xFEED
               	movw	%cx, (%rdx)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x2, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0xd(%rax), %rdx
               	movl	$0x77, %ecx
               	movb	%cl, (%rdx)
               	movl	$0x88, %ecx
               	movb	%cl, 0x1(%rdx)
               	movl	$0x99, %ecx
               	movb	%cl, 0x2(%rdx)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rdi
               	movzbq	(%rsi,%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x11, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xaa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
