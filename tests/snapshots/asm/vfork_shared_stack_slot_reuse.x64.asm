
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
               	popq	%r10
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	0x140(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x148(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0x150(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0x158(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0x160(%rsp), %rax
               	movq	%rax, 0xa0(%rsp)
               	movq	0x168(%rsp), %rax
               	movq	%rax, 0xb0(%rsp)
               	movq	0x170(%rsp), %rax
               	movq	%rax, 0xc0(%rsp)
               	movq	0x178(%rsp), %rax
               	movq	%rax, 0xd0(%rsp)
               	movq	0x180(%rsp), %rax
               	movq	%rax, 0xe0(%rsp)
               	movq	0x188(%rsp), %rax
               	movq	%rax, 0xf0(%rsp)
               	movq	0x190(%rsp), %rax
               	movq	%rax, 0x100(%rsp)
               	movq	0x198(%rsp), %rax
               	movq	%rax, 0x110(%rsp)
               	movq	0x1a0(%rsp), %rax
               	movq	%rax, 0x120(%rsp)
               	movq	0x1a8(%rsp), %rax
               	movq	%rax, 0x130(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movslq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x90(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xa0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xb0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xc0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xd0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xe0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0xf0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x100(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x110(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x120(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x130(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x140(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x140, %rsp            # imm = 0x140
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x580, %rsp            # imm = 0x580
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movslq	%ecx, %r12
               	movslq	0x4(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movslq	%ecx, %r13
               	movslq	0x8(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %r14
               	movslq	0xc(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %r15
               	movslq	0x10(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x4, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3e8(%rsp)
               	movslq	0x14(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3e0(%rsp)
               	movslq	0x18(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3d8(%rsp)
               	movslq	0x1c(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3d0(%rsp)
               	movslq	0x20(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x8, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3c8(%rsp)
               	movslq	0x24(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3c0(%rsp)
               	movslq	0x28(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x3b8(%rsp)
               	movslq	0x2c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x3b0(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x580, %rsp            # imm = 0x580
               	popq	%rbp
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	movslq	%eax, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	orq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	je	<addr>
               	orq	$0x4, %rbx
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r15
               	je	<addr>
               	orq	$0x8, %rbx
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3e8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3e0(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3d8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x40, %rbx
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3d0(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x80, %rbx
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3c8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x100, %rbx            # imm = 0x100
               	leaq	<rip>, %rax
               	movslq	0x24(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x9, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3c0(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x200, %rbx            # imm = 0x200
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3b8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x400, %rbx            # imm = 0x400
               	leaq	<rip>, %rax
               	movslq	0x2c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x3b0(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x800, %rbx            # imm = 0x800
               	movslq	%ebx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x580, %rsp            # imm = 0x580
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
               	addq	$0x580, %rsp            # imm = 0x580
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
               	movq	%r10, 0x350(%rsp)
               	movq	0x350(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x468(%rsp)
               	movq	0x468(%rsp), %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x460(%rsp)
               	movslq	0x70(%rax), %r10
               	movq	%r10, 0x340(%rsp)
               	movq	0x340(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x458(%rsp)
               	movq	0x458(%rsp), %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x450(%rsp)
               	movslq	0x74(%rax), %r10
               	movq	%r10, 0x330(%rsp)
               	movq	0x330(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x448(%rsp)
               	movq	0x448(%rsp), %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x440(%rsp)
               	movslq	0x78(%rax), %r10
               	movq	%r10, 0x320(%rsp)
               	movq	0x320(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x438(%rsp)
               	movq	0x438(%rsp), %r10
               	addq	$0xf, %r10
               	movq	%r10, 0x430(%rsp)
               	movslq	0x7c(%rax), %r10
               	movq	%r10, 0x310(%rsp)
               	movq	0x310(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x428(%rsp)
               	movq	0x428(%rsp), %r10
               	addq	$0x10, %r10
               	movq	%r10, 0x420(%rsp)
               	movslq	0x80(%rax), %r10
               	movq	%r10, 0x300(%rsp)
               	movq	0x300(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x418(%rsp)
               	movq	0x418(%rsp), %r10
               	addq	$0x11, %r10
               	movq	%r10, 0x410(%rsp)
               	movslq	0x84(%rax), %r10
               	movq	%r10, 0x2f0(%rsp)
               	movq	0x2f0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x408(%rsp)
               	movq	0x408(%rsp), %r10
               	addq	$0x12, %r10
               	movq	%r10, 0x400(%rsp)
               	movslq	0x88(%rax), %r10
               	movq	%r10, 0x2e0(%rsp)
               	movq	0x2e0(%rsp), %r10
               	leaq	(%r10,%r10,4), %r10
               	movq	%r10, 0x3f8(%rsp)
               	movq	0x3f8(%rsp), %r10
               	addq	$0x13, %r10
               	movq	%r10, 0x3f0(%rsp)
               	movslq	0x8c(%rax), %rax
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
               	addq	0x460(%rsp), %rcx
               	addq	0x450(%rsp), %rcx
               	addq	0x440(%rsp), %rcx
               	addq	0x430(%rsp), %rcx
               	addq	0x420(%rsp), %rcx
               	addq	0x410(%rsp), %rcx
               	addq	0x400(%rsp), %rcx
               	addq	0x3f0(%rsp), %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	ud2
