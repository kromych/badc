
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
               	subq	$0x278, %rsp            # imm = 0x278
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx      # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rbx
               	movl	0x4(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x1(%rcx), %r12
               	movl	0x8(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x2(%rcx), %r13
               	movl	0xc(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x3(%rcx), %r14
               	movl	0x10(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x4(%rcx), %r15
               	movl	0x14(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x5(%rcx), %r10
               	movq	%r10, 0x298(%rsp)
               	movl	0x18(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x6(%rcx), %r10
               	movq	%r10, 0x290(%rsp)
               	movl	0x1c(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x288(%rsp)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	cmpl	%eax, %r12d
               	je	<addr>
               	orq	$0x2, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %r13d
               	je	<addr>
               	orq	$0x4, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0xc(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	cmpl	%ecx, %r14d
               	je	<addr>
               	orq	$0x8, %rsi
               	movl	0x10(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rax
               	cmpl	%eax, %r15d
               	je	<addr>
               	orq	$0x10, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x14(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rcx, %r10
               	movq	0x298(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	je	<addr>
               	orq	$0x20, %rsi
               	movl	0x18(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rcx, %r10
               	movq	0x290(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	je	<addr>
               	orq	$0x40, %rsi
               	movl	0x1c(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movq	%rax, %r10
               	movq	0x288(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x80, %rsi
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
               	leaq	<rip>, %rax      # <addr>
               	movl	0x40(%rax), %ecx
               	leaq	(%rcx,%rcx,4), %rcx
               	incq	%rcx
               	movl	0x44(%rax), %edx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	$0x2, %rdx
               	movl	0x48(%rax), %esi
               	leaq	(%rsi,%rsi,4), %rsi
               	addq	$0x3, %rsi
               	movl	0x4c(%rax), %edi
               	leaq	(%rdi,%rdi,4), %rdi
               	addq	$0x4, %rdi
               	movl	0x50(%rax), %r8d
               	leaq	(%r8,%r8,4), %r8
               	addq	$0x5, %r8
               	movl	0x54(%rax), %r9d
               	leaq	(%r9,%r9,4), %r9
               	addq	$0x6, %r9
               	movl	0x58(%rax), %ebx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x7, %rbx
               	movl	0x5c(%rax), %r12d
               	leaq	(%r12,%r12,4), %r12
               	addq	$0x8, %r12
               	movl	0x60(%rax), %r13d
               	leaq	(%r13,%r13,4), %r13
               	addq	$0x9, %r13
               	movl	0x64(%rax), %r14d
               	leaq	(%r14,%r14,4), %r14
               	addq	$0xa, %r14
               	movl	0x68(%rax), %r15d
               	leaq	(%r15,%r15,4), %r15
               	addq	$0xb, %r15
               	movl	0x6c(%rax), %r10d
               	movq	%r10, 0x280(%rsp)
               	movq	0x280(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x278(%rsp)
               	movq	0x278(%rsp), %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x270(%rsp)
               	movl	0x70(%rax), %r10d
               	movq	%r10, 0x268(%rsp)
               	movq	0x268(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x260(%rsp)
               	movq	0x260(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x258(%rsp)
               	movl	0x74(%rax), %r10d
               	movq	%r10, 0x250(%rsp)
               	movq	0x250(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x248(%rsp)
               	movq	0x248(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x240(%rsp)
               	movl	0x78(%rax), %r10d
               	movq	%r10, 0x238(%rsp)
               	movq	0x238(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x230(%rsp)
               	movq	0x230(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x228(%rsp)
               	movl	0x7c(%rax), %r10d
               	movq	%r10, 0x220(%rsp)
               	movq	0x220(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x218(%rsp)
               	movq	0x218(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x210(%rsp)
               	movl	0x80(%rax), %r10d
               	movq	%r10, 0x208(%rsp)
               	movq	0x208(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x200(%rsp)
               	movq	0x200(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x1f8(%rsp)
               	movl	0x84(%rax), %r10d
               	movq	%r10, 0x1f0(%rsp)
               	movq	0x1f0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1e8(%rsp)
               	movq	0x1e8(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x1e0(%rsp)
               	movl	0x88(%rax), %r10d
               	movq	%r10, 0x1d8(%rsp)
               	movq	0x1d8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x1d0(%rsp)
               	movq	0x1d0(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x1c8(%rsp)
               	movl	0x8c(%rax), %eax
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x14, %rax
               	leaq	<rip>, %r10      # <addr>
               	movq	%r10, 0x1c0(%rsp)
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
               	addq	0x270(%rsp), %rcx
               	addq	0x258(%rsp), %rcx
               	addq	0x240(%rsp), %rcx
               	addq	0x228(%rsp), %rcx
               	addq	0x210(%rsp), %rcx
               	addq	0x1f8(%rsp), %rcx
               	addq	0x1e0(%rsp), %rcx
               	addq	0x1c8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x1c0(%rsp), %r10
               	movl	%eax, (%r10)
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
