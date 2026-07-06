
setjmp_spill_slots_unshared.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, (%rax,%rdx,4)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movslq	%ecx, %rdx
               	movslq	%edx, %rbx
               	movslq	0x4(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movslq	%ecx, %r12
               	movslq	0x8(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %r13
               	movslq	0xc(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %r14
               	movslq	0x10(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movslq	%ecx, %r15
               	movslq	0x14(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x338(%rsp)
               	movslq	0x18(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x330(%rsp)
               	movslq	0x1c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x328(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %edx
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	orq	$0x2, %rdx
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	orq	$0x4, %rdx
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	je	<addr>
               	orq	$0x8, %rdx
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r15
               	je	<addr>
               	orq	$0x10, %rdx
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x338(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x20, %rdx
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x330(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x40, %rdx
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x328(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x80, %rdx
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x340, %rsp            # imm = 0x340
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x340, %rsp            # imm = 0x340
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	0x40(%rax), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	incq	%rcx
               	movslq	0x44(%rax), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	$0x2, %rdx
               	movslq	0x48(%rax), %rsi
               	leaq	(%rsi,%rsi,4), %rsi
               	addq	$0x3, %rsi
               	movslq	0x4c(%rax), %rdi
               	leaq	(%rdi,%rdi,4), %rdi
               	addq	$0x4, %rdi
               	movslq	0x50(%rax), %r8
               	leaq	(%r8,%r8,4), %r8
               	addq	$0x5, %r8
               	movslq	0x54(%rax), %r9
               	leaq	(%r9,%r9,4), %r9
               	addq	$0x6, %r9
               	movslq	0x58(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x7, %rbx
               	movslq	0x5c(%rax), %r12
               	leaq	(%r12,%r12,4), %r12
               	addq	$0x8, %r12
               	movslq	0x60(%rax), %r13
               	leaq	(%r13,%r13,4), %r13
               	addq	$0x9, %r13
               	movslq	0x64(%rax), %r14
               	leaq	(%r14,%r14,4), %r14
               	addq	$0xa, %r14
               	movslq	0x68(%rax), %r15
               	leaq	(%r15,%r15,4), %r15
               	addq	$0xb, %r15
               	movslq	0x6c(%rax), %r10
               	movq	%r10, 0x2e8(%rsp)
               	movq	0x2e8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2e0(%rsp)
               	movq	0x2e0(%rsp), %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x2c8(%rsp)
               	movslq	0x70(%rax), %r10
               	movq	%r10, 0x298(%rsp)
               	movq	0x298(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x290(%rsp)
               	movq	0x290(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x278(%rsp)
               	movslq	0x74(%rax), %r10
               	movq	%r10, 0x248(%rsp)
               	movq	0x248(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x240(%rsp)
               	movq	0x240(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x228(%rsp)
               	movslq	0x78(%rax), %r10
               	movq	%r10, 0x1f8(%rsp)
               	movq	0x1f8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1f0(%rsp)
               	movq	0x1f0(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x1d8(%rsp)
               	movslq	0x7c(%rax), %r10
               	movq	%r10, 0x1a8(%rsp)
               	movq	0x1a8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1a0(%rsp)
               	movq	0x1a0(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x188(%rsp)
               	movslq	0x80(%rax), %r10
               	movq	%r10, 0x158(%rsp)
               	movq	0x158(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	0x150(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x138(%rsp)
               	movslq	0x84(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x108(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0x100(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0xe8(%rsp)
               	movslq	0x88(%rax), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x98(%rsp)
               	movslq	0x8c(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x14, %rax
               	leaq	<rip>, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	%rbx, %rcx
               	addq	%r12, %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x2c8(%rsp), %rcx
               	addq	0x278(%rsp), %rcx
               	addq	0x228(%rsp), %rcx
               	addq	0x1d8(%rsp), %rcx
               	addq	0x188(%rsp), %rcx
               	addq	0x138(%rsp), %rcx
               	addq	0xe8(%rsp), %rcx
               	addq	0x98(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, (%r10)
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x340, %rsp            # imm = 0x340
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
