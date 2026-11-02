
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
               	subq	$0x338, %rsp            # imm = 0x338
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
               	movq	%r10, 0x348(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x340(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x338(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x330(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x328(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xa(%rax), %r10
               	movq	%r10, 0x320(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0x318(%rsp)
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
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x1, %esi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	cmpl	%eax, %r12d
               	je	<addr>
               	orq	$0x2, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %r13d
               	je	<addr>
               	orq	$0x4, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x3, %rax
               	cmpl	%eax, %r14d
               	je	<addr>
               	orq	$0x8, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rax
               	cmpl	%eax, %r15d
               	je	<addr>
               	orq	$0x10, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x5, %rax
               	movq	%rax, %r10
               	movq	0x348(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x20, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x6, %rax
               	movq	%rax, %r10
               	movq	0x340(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x40, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movq	%rax, %r10
               	movq	0x338(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x80, %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x8, %rax
               	movq	%rax, %r10
               	movq	0x330(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x100, %rsi            # imm = 0x100
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x9, %rax
               	movq	%rax, %r10
               	movq	0x328(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x200, %rsi            # imm = 0x200
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xa, %rax
               	movq	%rax, %r10
               	movq	0x320(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	orq	$0x400, %rsi            # imm = 0x400
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movq	%rax, %r10
               	movq	0x318(%rsp), %rax
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
               	movq	%r10, 0x310(%rsp)
               	movq	0x310(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x308(%rsp)
               	movq	0x308(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x300(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x2f8(%rsp)
               	movq	0x2f8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2f0(%rsp)
               	movq	0x2f0(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x2e8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x2e0(%rsp)
               	movq	0x2e0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2d8(%rsp)
               	movq	0x2d8(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x2d0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x2c8(%rsp)
               	movq	0x2c8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2c0(%rsp)
               	movq	0x2c0(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x2b8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x2b0(%rsp)
               	movq	0x2b0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x2a8(%rsp)
               	movq	0x2a8(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x2a0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x298(%rsp)
               	movq	0x298(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x290(%rsp)
               	movq	0x290(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x288(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x280(%rsp)
               	movq	0x280(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x278(%rsp)
               	movq	0x278(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x270(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x268(%rsp)
               	movq	0x268(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x260(%rsp)
               	movq	0x260(%rsp), %r10
               	addq	$0x14, %r10
               	movq	%r10, 0x258(%rsp)
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
               	addq	0x300(%rsp), %rax
               	addq	0x2e8(%rsp), %rax
               	addq	0x2d0(%rsp), %rax
               	addq	0x2b8(%rsp), %rax
               	addq	0x2a0(%rsp), %rax
               	addq	0x288(%rsp), %rax
               	addq	0x270(%rsp), %rax
               	movq	%rax, %rdi
               	addq	0x258(%rsp), %rdi
               	andq	$0x7f, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
