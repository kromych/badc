
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
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rcx), %edx
               	movl	%edx, (%rax)
               	addq	$0x4, %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rdx, %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x6, 0x4(%rax)
               	movq	%rcx, %rsi
               	cmpl	$0x5, %esi
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	leaq	0x4(%rax), %rcx
               	movl	$0x6, (%rcx)
               	movslq	(%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	(%rax), %ecx
               	addq	$0x4, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	imulq	$0xf4243, %rax, %rdx    # imm = 0xF4243
               	subq	$0x5, %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r8
               	movb	%dil, (%r8)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	leaq	(%rdx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rcx,%rax), %rdi
               	movb	%sil, (%rdi)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %r8
               	movq	(%r8), %r8
               	leaq	(%rdi,%rax), %r9
               	movq	%r8, (%r9)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	leaq	(%rsi,%rax), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%rdx,%rax), %r8
               	movq	%rdi, (%r8)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdi
               	imulq	$0x7, %rax, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	cmpl	%esi, %edi
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
