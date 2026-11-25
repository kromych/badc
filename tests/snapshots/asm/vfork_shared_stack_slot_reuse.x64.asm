
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
               	subq	$0x190, %rsp            # imm = 0x190
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
               	movq	%r10, 0x178(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x170(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0x168(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0x160(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0x158(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x150(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x148(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x140(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x138(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x130(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xa(%rax), %r10
               	movq	%r10, 0x128(%rsp)
               	movl	<rip>, %eax # <addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	0xb(%rax), %r10
               	movq	%r10, 0x120(%rsp)
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
               	movq	0x178(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	movq	%rcx, %r10
               	movq	0x170(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	movq	%rcx, %r10
               	movq	0x168(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movq	%rax, %rdx
               	orq	$0x8, %rdx
               	movq	%rcx, %r10
               	movq	0x160(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	movq	%rcx, %r10
               	movq	0x158(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %r10
               	movq	0x150(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	movq	%rcx, %r10
               	movq	0x148(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movq	%rax, %rdx
               	orq	$0x80, %rdx
               	movq	%rcx, %r10
               	movq	0x140(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x8, %rcx
               	movq	%rax, %rdx
               	orq	$0x100, %rdx            # imm = 0x100
               	movq	%rcx, %r10
               	movq	0x138(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movq	%rax, %rdx
               	orq	$0x200, %rdx            # imm = 0x200
               	movq	%rcx, %r10
               	movq	0x130(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movq	%rax, %rdx
               	orq	$0x400, %rdx            # imm = 0x400
               	movq	%rcx, %r10
               	movq	0x128(%rsp), %rcx
               	cmpl	%r10d, %ecx
               	cmovneq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xb, %rcx
               	movq	%rax, %rsi
               	orq	$0x800, %rsi            # imm = 0x800
               	movq	%rcx, %r10
               	movq	0x120(%rsp), %rcx
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
               	movl	<rip>, %r10d # <addr>
               	leaq	(%r10,%r10,4), %r10
               	addq	$0x8, %r10
               	movl	<rip>, %r11d # <addr>
               	leaq	(%r11,%r11,4), %r11
               	addq	$0x9, %r11
               	movq	%r10, 0x10(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x118(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x110(%rsp)
               	addq	$0xa, %r10
               	movq	%r10, 0x108(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x100(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xf8(%rsp)
               	addq	$0xb, %r10
               	movq	%r10, 0xf0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xe8(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xe0(%rsp)
               	addq	$0xc, %r10
               	movq	%r10, 0xd8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xd0(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xc8(%rsp)
               	addq	$0xd, %r10
               	movq	%r10, 0xc0(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xb8(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0xb0(%rsp)
               	addq	$0xe, %r10
               	movq	%r10, 0xa8(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0xa0(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x98(%rsp)
               	addq	$0xf, %r10
               	movq	%r10, 0x90(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x88(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x80(%rsp)
               	addq	$0x10, %r10
               	movq	%r10, 0x78(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x70(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x68(%rsp)
               	addq	$0x11, %r10
               	movq	%r10, 0x60(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x58(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x50(%rsp)
               	addq	$0x12, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x40(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x38(%rsp)
               	addq	$0x13, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x28(%rsp)
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x20(%rsp)
               	addq	$0x14, %r10
               	movq	%r10, 0x18(%rsp)
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	movq	0x10(%rsp), %r10
               	addq	%r9, %rax
               	addq	%r10, %rax
               	addq	%r11, %rax
               	addq	0x108(%rsp), %rax
               	addq	0xf0(%rsp), %rax
               	addq	0xd8(%rsp), %rax
               	addq	0xc0(%rsp), %rax
               	addq	0xa8(%rsp), %rax
               	addq	0x90(%rsp), %rax
               	addq	0x78(%rsp), %rax
               	addq	0x60(%rsp), %rax
               	addq	0x48(%rsp), %rax
               	addq	0x30(%rsp), %rax
               	movq	%rax, %rdi
               	addq	0x18(%rsp), %rdi
               	andq	$0x7f, %rdi
               	callq	<addr>
               	ud2
