
byte_store_wide_merge.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movq	%rsi, %rax
               	bswapq	%rax
               	movq	%rax, (%rdi)
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
               	andq	$0xff, %rsi
               	movb	%sil, 0x2(%rdi)
               	retq

<main>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	movq	$0x44332211, (%rsp)     # imm = 0x44332211
               	leaq	<rip>, %rdx # <addr>
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	(%rsp), %rax
               	movl	$0x11223344, 0x4(%rsp)  # imm = 0x11223344
               	leaq	0x4(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	(%rsp), %rax
               	movl	$0xddccbbaa, 0x9(%rsp)  # imm = 0xDDCCBBAA
               	leaq	0x9(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	(%rsp), %rax
               	movabsq	$0x807060504030201, %rcx # imm = 0x807060504030201
               	movq	%rcx, 0x1(%rsp)
               	leaq	0x1(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	leaq	(%rsp), %rax
               	movw	$0xfeed, 0xb(%rsp)      # imm = 0xFEED
               	leaq	0xb(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	(%rsp), %rax
               	movb	$0x77, 0xd(%rsp)
               	movw	$0x9988, 0xe(%rsp)      # imm = 0x9988
               	leaq	0xd(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	movzbq	(%rsp), %rax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	movzbq	0x9(%rsp), %rax
               	cmpl	$0xaa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
