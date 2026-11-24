
aggregate_copy_site_temps.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xc8, %rsp
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x38(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	leaq	0x78(%rsp), %rcx
               	leaq	0x38(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x38(%rsp,%rax), %rsi
               	movzbq	0x78(%rsp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x30(%rsp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0xc, %eax
               	jb	<addr>
               	leaq	0x70(%rsp), %rcx
               	leaq	0x30(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	xorl	%eax, %eax
               	movzbq	0x30(%rsp,%rax), %rsi
               	movzbq	0x70(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	movl	$0x3, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x30(%rsp,%rax)
               	incq	%rax
               	cmpl	$0xd, %eax
               	jb	<addr>
               	leaq	0x70(%rsp), %rcx
               	leaq	0x30(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movzbq	0xc(%rdx), %r10
               	movb	%r10b, 0xc(%rcx)
               	xorl	%eax, %eax
               	movzbq	0x30(%rsp,%rax), %rsi
               	movzbq	0x70(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xd, %eax
               	jb	<addr>
               	movl	$0x4, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x28(%rsp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %eax
               	jb	<addr>
               	leaq	0x68(%rsp), %rcx
               	leaq	0x28(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	0x28(%rsp), %rax
               	movq	0x38(%rsp), %rsi
               	leaq	(%rax,%rsi), %rdi
               	addq	%rsi, %rax
               	cmpq	%rax, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	0x28(%rsp,%rax), %rsi
               	movzbq	0x68(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	movl	$0x5, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x18(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	0x58(%rsp), %rcx
               	leaq	0x18(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rdx), %r10
               	movq	%r10, 0x20(%rcx)
               	movq	0x38(%rsp), %rax
               	leaq	0xe(%rax), %rsi
               	addq	$0xe, %rax
               	cmpq	%rax, %rsi
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	0x18(%rsp,%rax), %rsi
               	movzbq	0x58(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x28, %eax
               	jb	<addr>
               	movl	$0x6, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x18(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	0x58(%rsp), %rcx
               	leaq	0x18(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rdx), %r10
               	movq	%r10, 0x20(%rcx)
               	xorl	%eax, %eax
               	movzbq	0x18(%rsp,%rax), %rsi
               	movzbq	0x58(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	movl	$0x7, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x8(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jb	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x20(%rax), %rdx
               	leaq	0x8(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x8(%rsp,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jb	<addr>
               	movl	$0x8, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x40(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x3e, %eax
               	jb	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	leaq	0x1f(%rax), %rcx
               	addq	$0x1f, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movl	0x18(%rdx), %r10d
               	movl	%r10d, 0x18(%rcx)
               	movzwq	0x1c(%rdx), %r10
               	movw	%r10w, 0x1c(%rcx)
               	movzbq	0x1e(%rdx), %r10
               	movb	%r10b, 0x1e(%rcx)
               	movsbq	0x1e(%rcx), %rax
               	addq	$0xaf, %rax
               	movsbq	0x7d(%rsp), %rsi
               	addq	$0xaf, %rsi
               	cmpl	%esi, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x1f, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x9, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x208, %eax            # imm = 0x208
               	jb	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, %r11
               	movq	%rcx, %rax
               	leaq	0x200(%r11), %rdi
               	movups	(%r11), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %r11
               	addq	$0x10, %rax
               	cmpq	%rdi, %r11
               	jne	<addr>
               	movq	(%r11), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x208, %eax            # imm = 0x208
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xa, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20c, %eax            # imm = 0x20C
               	jb	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, %r11
               	movq	%rcx, %rax
               	leaq	0x200(%r11), %rdi
               	movups	(%r11), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %r11
               	addq	$0x10, %rax
               	cmpq	%rdi, %r11
               	jne	<addr>
               	movq	(%r11), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%r11), %r10d
               	movl	%r10d, 0x8(%rax)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20c, %eax            # imm = 0x20C
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xb, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jb	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, %r11
               	movq	%rcx, %rax
               	leaq	0x3e0(%r11), %rdi
               	movups	(%r11), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %r11
               	addq	$0x10, %rax
               	cmpq	%rdi, %r11
               	jne	<addr>
               	movq	(%r11), %r10
               	movq	%r10, (%rax)
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rsi # <addr>
               	cmpl	%esi, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xc, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x1008, %eax           # imm = 0x1008
               	jb	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, %r11
               	movq	%rcx, %rax
               	leaq	0x1000(%r11), %rdi
               	movups	(%r11), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %r11
               	addq	$0x10, %rax
               	cmpq	%rdi, %r11
               	jne	<addr>
               	movq	(%r11), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x1008, %eax           # imm = 0x1008
               	jb	<addr>
               	xorl	%eax, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0xd, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0xc, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0xb, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0xa, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x9, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x8, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x4, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0xc8, %rsp
               	retq
