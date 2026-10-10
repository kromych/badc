
vfork_shared_stack_slot_reuse.x64:	file format elf64-x86-64

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

<child_exec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movl	0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x20(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x30(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x40(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x48(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x50(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x58(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x60(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x68(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x70(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x78(%rbp), %ecx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x368, %rsp            # imm = 0x368
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
               	movq	%r10, 0x378(%rsp)
               	movl	0x18(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x6(%rcx), %r10
               	movq	%r10, 0x370(%rsp)
               	movl	0x1c(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x7(%rcx), %r10
               	movq	%r10, 0x368(%rsp)
               	movl	0x20(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x8(%rcx), %r10
               	movq	%r10, 0x360(%rsp)
               	movl	0x24(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x9(%rcx), %r10
               	movq	%r10, 0x358(%rsp)
               	movl	0x28(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0xa(%rcx), %r10
               	movq	%r10, 0x350(%rsp)
               	movl	0x2c(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0x348(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%edi, %edi
               	je	<addr>
               	xorl	%edx, %edx
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
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
               	movl	0xc(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x3, %rax
               	cmpl	%eax, %r14d
               	je	<addr>
               	orq	$0x8, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x10(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rax
               	cmpl	%eax, %r15d
               	je	<addr>
               	orq	$0x10, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x14(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x5, %rax
               	movq	%rax, %r10
               	movq	0x378(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x20, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x18(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x6, %rax
               	movq	%rax, %r10
               	movq	0x370(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x40, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	0x1c(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rcx, %r10
               	movq	0x368(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	je	<addr>
               	orq	$0x80, %rsi
               	movl	0x20(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x8, %rax
               	movq	%rax, %r10
               	movq	0x360(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x100, %rsi            # imm = 0x100
               	leaq	<rip>, %rax      # <addr>
               	movl	0x24(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movq	%rcx, %r10
               	movq	0x358(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	je	<addr>
               	orq	$0x200, %rsi            # imm = 0x200
               	movl	0x28(%rax), %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movq	%rcx, %r10
               	movq	0x350(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	je	<addr>
               	orq	$0x400, %rsi            # imm = 0x400
               	movl	0x2c(%rax), %eax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movq	%rax, %r10
               	movq	0x348(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x800, %rsi            # imm = 0x800
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
               	movq	%r10, 0x340(%rsp)
               	movq	0x340(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x338(%rsp)
               	movq	0x338(%rsp), %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x330(%rsp)
               	movl	0x70(%rax), %r10d
               	movq	%r10, 0x328(%rsp)
               	movq	0x328(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x320(%rsp)
               	movq	0x320(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x318(%rsp)
               	movl	0x74(%rax), %r10d
               	movq	%r10, 0x310(%rsp)
               	movq	0x310(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x308(%rsp)
               	movq	0x308(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x300(%rsp)
               	movl	0x78(%rax), %r10d
               	movq	%r10, 0x2f8(%rsp)
               	movq	0x2f8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2f0(%rsp)
               	movq	0x2f0(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x2e8(%rsp)
               	movl	0x7c(%rax), %r10d
               	movq	%r10, 0x2e0(%rsp)
               	movq	0x2e0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2d8(%rsp)
               	movq	0x2d8(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x2d0(%rsp)
               	movl	0x80(%rax), %r10d
               	movq	%r10, 0x2c8(%rsp)
               	movq	0x2c8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2c0(%rsp)
               	movq	0x2c0(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x2b8(%rsp)
               	movl	0x84(%rax), %r10d
               	movq	%r10, 0x2b0(%rsp)
               	movq	0x2b0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2a8(%rsp)
               	movq	0x2a8(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x2a0(%rsp)
               	movl	0x88(%rax), %r10d
               	movq	%r10, 0x298(%rsp)
               	movq	0x298(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x290(%rsp)
               	movq	0x290(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x288(%rsp)
               	movl	0x8c(%rax), %eax
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x14, %rax
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
               	addq	0x330(%rsp), %rcx
               	addq	0x318(%rsp), %rcx
               	addq	0x300(%rsp), %rcx
               	addq	0x2e8(%rsp), %rcx
               	addq	0x2d0(%rsp), %rcx
               	addq	0x2b8(%rsp), %rcx
               	addq	0x2a0(%rsp), %rcx
               	addq	0x288(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
