
vfork_shared_stack_slot_reuse.x64:	file format elf64-x86-64

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

<stir>:
               	movl	<rip>, %eax # <addr>
               	xorq	$0x1, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<child_exec>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x20(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x30(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x40(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x48(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x50(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x58(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x60(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x68(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x70(%rsp), %ecx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movq	%rcx, %rax
               	nop
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %r10
               	movq	%r10, 0xf8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0xe8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0xe0(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0xd8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0xd0(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0xc8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0xc0(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0xb8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0xb0(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xa(%rax), %r10
               	movq	%r10, 0xa8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0xa0(%rsp)
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	testl	%edi, %edi
               	je	<addr>
               	xorl	%edx, %edx
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	$0x1, %edx
               	movq	%rcx, %r10
               	movq	0xf8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	movq	%rcx, %r10
               	movq	0xf0(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	movq	%rcx, %r10
               	movq	0xe8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movq	%rax, %rdx
               	orq	$0x8, %rdx
               	movq	%rcx, %r10
               	movq	0xe0(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	movq	%rcx, %r10
               	movq	0xd8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %r10
               	movq	0xd0(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %r10
               	movq	0xc8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rax, %rdx
               	orq	$0x80, %rdx
               	movq	%rcx, %r10
               	movq	0xc0(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x8, %rcx
               	movq	%rax, %rdx
               	orq	$0x100, %rdx            # imm = 0x100
               	movq	%rcx, %r10
               	movq	0xb8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movq	%rax, %rdx
               	orq	$0x200, %rdx            # imm = 0x200
               	movq	%rcx, %r10
               	movq	0xb0(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movq	%rax, %rdx
               	orq	$0x400, %rdx            # imm = 0x400
               	movq	%rcx, %r10
               	movq	0xa8(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xb, %rcx
               	movq	%rax, %rsi
               	orq	$0x800, %rsi            # imm = 0x800
               	movq	%rcx, %r10
               	movq	0xa0(%rsp), %rcx
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
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0x88(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0x80(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xa(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xc(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xd(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xe(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0xf(%rax), %r10
               	movq	%r10, 0x28(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, 0x20(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x11(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x12(%rax), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x13(%rax), %r10
               	movq	%r10, 0x8(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,4), %rax
               	leaq	0x14(%rax), %r10
               	movq	%r10, (%rsp)
               	callq	<addr>
               	movq	0x98(%rsp), %rax
               	addq	0x90(%rsp), %rax
               	addq	0x88(%rsp), %rax
               	addq	0x80(%rsp), %rax
               	addq	0x78(%rsp), %rax
               	addq	0x70(%rsp), %rax
               	addq	0x68(%rsp), %rax
               	addq	0x60(%rsp), %rax
               	addq	0x58(%rsp), %rax
               	addq	0x50(%rsp), %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	addq	0x30(%rsp), %rax
               	addq	0x28(%rsp), %rax
               	addq	0x20(%rsp), %rax
               	addq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	addq	0x8(%rsp), %rax
               	movq	%rax, %rdi
               	addq	(%rsp), %rdi
               	andq	$0x7f, %rdi
               	callq	<addr>
               	ud2
