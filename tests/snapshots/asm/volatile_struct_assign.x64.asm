
volatile_struct_assign.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x400000003, %rcx      # imm = 0x400000003
               	movq	%rcx, (%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, <rip> # <addr>
               	movl	0x4(%rax), %eax
               	movl	%eax, <rip> # <addr>
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, <rip> # <addr>
               	movl	$0x6, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, <rip> # <addr>
               	movl	$0x6, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0xf4243, %rax, %rdx    # imm = 0xF4243
               	subq	$0x5, %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r8
               	movb	%dil, (%r8)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rcx,%rax), %rdi
               	movb	%sil, (%rdi)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r8
               	movq	(%r8), %r8
               	leaq	(%rdi,%rax), %r9
               	movq	%r8, (%r9)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%rdx,%rax), %r8
               	movq	%rdi, (%r8)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	imulq	$0x7, %rax, %rdi
               	incq	%rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rcx
               	imulq	$0xf4243, %rax, %rsi    # imm = 0xF4243
               	subq	$0x5, %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
