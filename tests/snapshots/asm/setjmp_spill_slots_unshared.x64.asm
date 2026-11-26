
setjmp_spill_slots_unshared.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movq	%rcx, %rax
               	nopl	(%rax,%rax)
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0x28(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0x20(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, (%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	$0x1, %edx
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	movq	%rcx, %r10
               	movq	0x30(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movq	%rax, %rdx
               	orq	$0x8, %rdx
               	movq	%rcx, %r10
               	movq	0x20(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	movq	%rcx, %r10
               	movq	0x18(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %r10
               	movq	0x10(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %r10
               	movq	0x8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rax, %rsi
               	orq	$0x80, %rsi
               	movq	%rcx, %r10
               	movq	(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmoveq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	incq	%rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x2, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x4, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x5, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x6, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x7, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x8, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x9, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xc, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xd, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xe, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0xf, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x10, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x11, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x12, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x13, %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x14, %rcx
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	ud2
