
loop_idiom_version.x64:	file format elf64-x86-64

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

<blocked3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	cmpl	$0x2, %r13d
               	jbe	<addr>
               	movq	%rbx, %rax
               	subq	%r12, %rax
               	movl	%r13d, %ecx
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%r13d, %r13d
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%r13, %rax
               	shrq	$0x21, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %rbx
               	addq	%rax, %r12
               	subq	%rax, %r13
               	testl	%r13d, %r13d
               	je	<addr>
               	incq	%rbx
               	incq	%r12
               	movzbq	-0x1(%r12), %rax
               	movb	%al, -0x1(%rbx)
               	decq	%r13
               	testl	%r13d, %r13d
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movzbq	(%r12), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r12), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r12), %rax
               	movb	%al, 0x2(%rbx)
               	addq	$0x3, %rbx
               	addq	$0x3, %r12
               	subq	$0x3, %r13
               	cmpl	$0x2, %r13d
               	ja	<addr>
               	jmp	<addr>

<walk1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	testl	%edx, %edx
               	jbe	<addr>
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movl	%edx, %eax
               	cmpq	%rax, %rcx
               	jb	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movzbq	(%rsi), %rax
               	movb	%al, (%rdi)
               	incq	%rdi
               	incq	%rsi
               	decq	%rdx
               	testl	%edx, %edx
               	ja	<addr>
               	jmp	<addr>

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movslq	%edx, %r13
               	movslq	%esi, %r12
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %r8
               	movb	%r8b, (%rcx,%rax)
               	leaq	<rip>, %rcx # <addr>
               	movb	%r8b, (%rcx,%rax)
               	movq	%r8, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	(%rax,%r12), %rdi
               	leaq	(%rax,%r13), %rsi
               	movq	%rbx, %rdx
               	callq	*%r9
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%r12), %rax
               	addq	%r13, %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movl	-0x8(%rbp), %edx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
               	leaq	-<rip>, %rdi # <addr>
               	movq	%r13, %rsi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	movq	%r13, %rsi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jbe	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	xorl	%r13d, %r13d
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx # <addr>
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	(%rax,%r13), %rcx
               	leaq	(%rax,%r12), %rdx
               	xorl	%eax, %eax
               	testl	%ebx, %ebx
               	jle	<addr>
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	cmpq	%rbx, %rsi
               	jb	<addr>
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%r13), %rax
               	addq	%r12, %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movl	-0x8(%rbp), %edx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movzbq	(%rdx,%rax), %rsi
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movb	%cl, (%rsi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx # <addr>
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%r12), %rdx
               	xorl	%eax, %eax
               	testl	%ebx, %ebx
               	jle	<addr>
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	cmpq	%rbx, %rsi
               	jb	<addr>
               	movq	%rcx, %rdi
               	movq	%rdx, %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	(%rax,%r12), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movl	-0x8(%rbp), %edx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx # <addr>
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%r12), %rdx
               	xorl	%eax, %eax
               	testl	%ebx, %ebx
               	jle	<addr>
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	cmpq	%rbx, %rsi
               	jb	<addr>
               	movq	%rdx, %rdi
               	movq	%rbx, %rdx
               	movq	%rcx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	(%rax,%r12), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rax,%rsi), %rsi
               	movb	%sil, (%rcx,%rdx)
               	movl	-0x8(%rbp), %edx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movzbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	jmp	<addr>
               	movzbq	(%rdx,%rax), %rsi
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x20(%rsi), %rdi
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rsi,%rax)
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	cmpq	$0x9, %rax
               	jb	<addr>
               	movl	$0x9, %edx
               	xchgq	%rsi, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x9(%rax), %rdx
               	leaq	<rip>, %rax # <addr>
               	addq	$0x20, %rax
               	addq	$0x9, %rax
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x9(%rdi), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	0x29(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rsi
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1020304, <rip> # imm = 0x1020304
                                                # <addr>
               	movl	$0x1020304, <rip> # imm = 0x1020304
                                                # <addr>
               	movl	$0x2040608, <rip> # imm = 0x2040608
                                                # <addr>
               	movl	$0x2040608, <rip> # imm = 0x2040608
                                                # <addr>
               	movl	$0x306090c, <rip> # imm = 0x306090C
                                                # <addr>
               	movl	$0x306090c, <rip> # imm = 0x306090C
                                                # <addr>
               	movl	$0x4080c10, <rip> # imm = 0x4080C10
                                                # <addr>
               	movl	$0x4080c10, <rip> # imm = 0x4080C10
                                                # <addr>
               	movl	$0x50a0f14, <rip> # imm = 0x50A0F14
                                                # <addr>
               	movl	$0x50a0f14, <rip> # imm = 0x50A0F14
                                                # <addr>
               	movl	$0x60c1218, <rip> # imm = 0x60C1218
                                                # <addr>
               	movl	$0x60c1218, <rip> # imm = 0x60C1218
                                                # <addr>
               	movl	$0x70e151c, <rip> # imm = 0x70E151C
                                                # <addr>
               	movl	$0x70e151c, <rip> # imm = 0x70E151C
                                                # <addr>
               	movl	$0x8101820, <rip> # imm = 0x8101820
                                                # <addr>
               	movl	$0x8101820, <rip> # imm = 0x8101820
                                                # <addr>
               	movl	$0x9121b24, <rip> # imm = 0x9121B24
                                                # <addr>
               	movl	$0x9121b24, <rip> # imm = 0x9121B24
                                                # <addr>
               	movl	$0xa141e28, <rip> # imm = 0xA141E28
                                                # <addr>
               	movl	$0xa141e28, <rip> # imm = 0xA141E28
                                                # <addr>
               	movl	$0xb16212c, <rip> # imm = 0xB16212C
                                                # <addr>
               	movl	$0xb16212c, <rip> # imm = 0xB16212C
                                                # <addr>
               	movl	$0xc182430, <rip> # imm = 0xC182430
                                                # <addr>
               	movl	$0xc182430, <rip> # imm = 0xC182430
                                                # <addr>
               	movl	$0xd1a2734, <rip> # imm = 0xD1A2734
                                                # <addr>
               	movl	$0xd1a2734, <rip> # imm = 0xD1A2734
                                                # <addr>
               	movl	$0xe1c2a38, <rip> # imm = 0xE1C2A38
                                                # <addr>
               	movl	$0xe1c2a38, <rip> # imm = 0xE1C2A38
                                                # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0xf1e2d3c, <rip> # imm = 0xF1E2D3C
                                                # <addr>
               	movl	$0xf1e2d3c, <rip> # imm = 0xF1E2D3C
                                                # <addr>
               	movl	$0x10203040, <rip> # imm = 0x10203040
                                                # <addr>
               	movl	$0x10203040, <rip> # imm = 0x10203040
                                                # <addr>
               	leaq	0x20(%rax), %rcx
               	movl	$0x8, %edx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x20, %rsi
               	jb	<addr>
               	movl	$0x20, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0x20, %edx
               	leaq	0x20(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rsi), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movups	0x30(%rsi), %xmm14
               	movups	%xmm14, 0x30(%rdi)
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	(%rcx), %esi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %esi
               	movl	%esi, 0xc(%rax)
               	addq	$0x10, %rax
               	addq	$0x10, %rcx
               	subq	$0x4, %rdx
               	cmpl	$0x4, %edx
               	jae	<addr>
               	jmp	<addr>
               	movzbq	(%rdi), %rax
               	movb	%al, <rip> # <addr>
               	movzbq	0x1(%rdi), %rax
               	movb	%al, <rip> # <addr>
               	movzbq	0x2(%rdi), %rax
               	movb	%al, <rip> # <addr>
               	leaq	0x3(%rsi), %rax
               	leaq	0x3(%rdi), %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	addq	$0x3, %rax
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	0x3(%rax), %rdx
               	leaq	0x3(%rcx), %rax
               	jmp	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
