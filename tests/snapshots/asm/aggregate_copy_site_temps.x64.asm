
aggregate_copy_site_temps.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0xd0(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xc0(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rcx
               	movq	%rcx, (%rdx)
               	movq	-0x8(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdx
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movl	$0x3, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0xd, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movzbq	0xc(%rdx), %r10
               	movb	%r10b, 0xc(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xd, %eax
               	jb	<addr>
               	leaq	-0x58(%rbp), %rdx
               	movl	$0x4, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x58(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rdx)
               	movq	(%rcx), %rax
               	movq	0x10(%rcx), %rsi
               	leaq	(%rax,%rsi), %rdi
               	addq	%rsi, %rax
               	cmpq	%rax, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	leaq	-0x68(%rbp), %rdx
               	movl	$0x5, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rdx), %r10
               	movq	%r10, 0x20(%rcx)
               	movq	0x20(%rcx), %rax
               	addq	$0xe, %rax
               	movq	0x20(%rdx), %rsi
               	addq	$0xe, %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	-0x68(%rbp), %rdx
               	movl	$0x6, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x68(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rdx), %r10
               	movq	%r10, 0x20(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x7, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jb	<addr>
               	leaq	-0xc0(%rbp), %rax
               	leaq	0x20(%rax), %rdx
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jb	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movl	$0x8, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x3e, %eax
               	jb	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x80(%rbp), %rax
               	addq	$0x1f, %rcx
               	leaq	0x1f(%rax), %rdx
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
               	movsbq	0x1e(%rcx), %rsi
               	addq	$0xaf, %rsi
               	movsbq	0x3d(%rax), %rax
               	addq	$0xaf, %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x1f, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
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
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20c, %eax            # imm = 0x20C
               	jb	<addr>
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
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
               	movsbq	0x3e7(%rcx), %rax
               	movsbq	0x3e7(%rdx), %rsi
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
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
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
               	cmpl	$0x1008, %eax           # imm = 0x1008
               	jb	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7, %eax
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
