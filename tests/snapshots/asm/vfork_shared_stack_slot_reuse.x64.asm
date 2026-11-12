
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
               	subq	$0x118, %rsp            # imm = 0x118
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
               	movq	%r10, 0x128(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x120(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x118(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x110(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xa(%rax), %r10
               	movq	%r10, 0x100(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0xf8(%rsp)
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
               	movq	0x128(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %r10
               	movq	0x120(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rax, %rdx
               	orq	$0x80, %rdx
               	movq	%rcx, %r10
               	movq	0x118(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x8, %rcx
               	movq	%rax, %rdx
               	orq	$0x100, %rdx            # imm = 0x100
               	movq	%rcx, %r10
               	movq	0x110(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movq	%rax, %rdx
               	orq	$0x200, %rdx            # imm = 0x200
               	movq	%rcx, %r10
               	movq	0x108(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movq	%rax, %rdx
               	orq	$0x400, %rdx            # imm = 0x400
               	movq	%rcx, %r10
               	movq	0x100(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xb, %rcx
               	movq	%rax, %rsi
               	orq	$0x800, %rsi            # imm = 0x800
               	movq	%rcx, %r10
               	movq	0xf8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmoveq	%rax, %rsi
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
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xe8(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0xe0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xd8(%rsp)
               	movq	0xd8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd0(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0xc8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0xb0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x98(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x90(%rsp)
               	movq	0x90(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x80(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x68(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x50(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	$0x14, %r10
               	movq	%r10, 0x38(%rsp)
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
               	addq	0xe0(%rsp), %rax
               	addq	0xc8(%rsp), %rax
               	addq	0xb0(%rsp), %rax
               	addq	0x98(%rsp), %rax
               	addq	0x80(%rsp), %rax
               	addq	0x68(%rsp), %rax
               	addq	0x50(%rsp), %rax
               	movq	%rax, %rdi
               	addq	0x38(%rsp), %rdi
               	andq	$0x7f, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
