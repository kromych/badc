
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
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1(%rdi)
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x2(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movl	$0x44332211, %edx       # imm = 0x44332211
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rdx
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, 0x4(%rax)
               	leaq	0x4(%rax), %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x9(%rax), %rcx
               	movl	$0xddccbbaa, %edx       # imm = 0xDDCCBBAA
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	movabsq	$0x807060504030201, %rdx # imm = 0x807060504030201
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x8, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0xb(%rax), %rcx
               	movl	$0xfeed, %edx           # imm = 0xFEED
               	movw	%dx, (%rcx)
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0xd(%rax), %rcx
               	movl	$0x77, %edx
               	movb	%dl, (%rcx)
               	movl	$0x88, %edx
               	movb	%dl, 0x1(%rcx)
               	movl	$0x99, %edx
               	movb	%dl, 0x2(%rcx)
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x3, %eax
               	jae	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
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
