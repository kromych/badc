
setjmp_spill_slots_unshared.x64:	file format elf64-x86-64

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
               	subq	$0x258, %rsp            # imm = 0x258
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rbx
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %r12
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x2(%rax), %r13
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x3(%rax), %r14
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x4(%rax), %r15
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x278(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x270(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x268(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	$0x1, %edx
               	cmpl	%ecx, %ebx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	cmpl	%ecx, %r12d
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	cmpl	%ecx, %r13d
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movq	%rax, %rdx
               	orq	$0x8, %rdx
               	cmpl	%ecx, %r14d
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	cmpl	%ecx, %r15d
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %r10
               	movq	0x278(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %r10
               	movq	0x270(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rax, %rdx
               	orq	$0x80, %rdx
               	movq	%rcx, %r10
               	movq	0x268(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	movq	%rax, %rsi
               	cmovneq	%rdx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	incq	%rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x2, %rcx
               	movl	<rip>, %edx # <addr>
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	$0x3, %rdx
               	movl	<rip>, %esi # <addr>
               	leaq	(%rsi,%rsi,4), %rsi
               	addq	$0x4, %rsi
               	movl	<rip>, %edi # <addr>
               	leaq	(%rdi,%rdi,4), %rdi
               	addq	$0x5, %rdi
               	movl	<rip>, %r8d # <addr>
               	leaq	(%r8,%r8,4), %r8
               	addq	$0x6, %r8
               	movl	<rip>, %r9d # <addr>
               	leaq	(%r9,%r9,4), %r9
               	addq	$0x7, %r9
               	movl	<rip>, %ebx # <addr>
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x8, %rbx
               	movl	<rip>, %r12d # <addr>
               	leaq	(%r12,%r12,4), %r12
               	addq	$0x9, %r12
               	movl	<rip>, %r13d # <addr>
               	leaq	(%r13,%r13,4), %r13
               	addq	$0xa, %r13
               	movl	<rip>, %r14d # <addr>
               	leaq	(%r14,%r14,4), %r14
               	addq	$0xb, %r14
               	movl	<rip>, %r15d # <addr>
               	leaq	(%r15,%r15,4), %r15
               	addq	$0xc, %r15
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x260(%rsp)
               	movq	0x260(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x258(%rsp)
               	movq	0x258(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x250(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x248(%rsp)
               	movq	0x248(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x240(%rsp)
               	movq	0x240(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x238(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x230(%rsp)
               	movq	0x230(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x228(%rsp)
               	movq	0x228(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x220(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x218(%rsp)
               	movq	0x218(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x210(%rsp)
               	movq	0x210(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x208(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x200(%rsp)
               	movq	0x200(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1f8(%rsp)
               	movq	0x1f8(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x1f0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x1e8(%rsp)
               	movq	0x1e8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1e0(%rsp)
               	movq	0x1e0(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x1d8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x1d0(%rsp)
               	movq	0x1d0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1c8(%rsp)
               	movq	0x1c8(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x1c0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x1b8(%rsp)
               	movq	0x1b8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1b0(%rsp)
               	movq	0x1b0(%rsp), %r10
               	addq	$0x14, %r10
               	movq	%r10, 0x1a8(%rsp)
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x250(%rsp), %rax
               	addq	0x238(%rsp), %rax
               	addq	0x220(%rsp), %rax
               	addq	0x208(%rsp), %rax
               	addq	0x1f0(%rsp), %rax
               	addq	0x1d8(%rsp), %rax
               	addq	0x1c0(%rsp), %rax
               	addq	0x1a8(%rsp), %rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
