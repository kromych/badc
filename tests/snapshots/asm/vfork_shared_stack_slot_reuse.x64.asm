
vfork_shared_stack_slot_reuse.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	subq	$0x430, %rsp            # imm = 0x430
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
               	movslq	%ecx, %rdx
               	movslq	%edx, %r12
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
               	movq	%r10, 0x258(%rsp)
               	movslq	0x14(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x250(%rsp)
               	movslq	0x18(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x248(%rsp)
               	movslq	0x1c(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x7, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x240(%rsp)
               	movslq	0x20(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x8, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x238(%rsp)
               	movslq	0x24(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x9, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x230(%rsp)
               	movslq	0x28(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x228(%rsp)
               	movslq	0x2c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x220(%rsp)
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
               	addq	$0x430, %rsp            # imm = 0x430
               	popq	%rbp
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x78(%rbp)
               	movslq	%eax, %rdi
               	leaq	-0x78(%rbp), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movq	0x258(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x250(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x248(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x40, %rbx
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x240(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x80, %rbx
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x238(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x100, %rbx            # imm = 0x100
               	leaq	<rip>, %rax
               	movslq	0x24(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x9, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x230(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x200, %rbx            # imm = 0x200
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x228(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x400, %rbx            # imm = 0x400
               	leaq	<rip>, %rax
               	movslq	0x2c(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	$0xb, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x220(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	orq	$0x800, %rbx            # imm = 0x800
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x430, %rsp            # imm = 0x430
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
               	addq	$0x430, %rsp            # imm = 0x430
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
               	leaq	0x1(%rcx), %rdi
               	movslq	0x44(%rax), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	leaq	0x2(%rcx), %rsi
               	movslq	0x48(%rax), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	leaq	0x3(%rcx), %rdx
               	movslq	0x4c(%rax), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	$0x4, %rcx
               	movslq	0x50(%rax), %r8
               	leaq	(%r8,%r8,4), %r8
               	addq	$0x5, %r8
               	movslq	0x54(%rax), %r9
               	leaq	(%r9,%r9,4), %r9
               	addq	$0x6, %r9
               	movslq	0x58(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x7, %rbx
               	movslq	%ebx, %r12
               	movslq	0x5c(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x8, %rbx
               	movslq	%ebx, %r13
               	movslq	0x60(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x9, %rbx
               	movslq	%ebx, %r14
               	movslq	0x64(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xa, %rbx
               	movslq	%ebx, %r15
               	movslq	0x68(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xb, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x218(%rsp)
               	movslq	0x6c(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xc, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x210(%rsp)
               	movslq	0x70(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xd, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x208(%rsp)
               	movslq	0x74(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xe, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x200(%rsp)
               	movslq	0x78(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0xf, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x1f8(%rsp)
               	movslq	0x7c(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x10, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x1f0(%rsp)
               	movslq	0x80(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x11, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x1e8(%rsp)
               	movslq	0x84(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x12, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x1e0(%rsp)
               	movslq	0x88(%rax), %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	$0x13, %rbx
               	movslq	%ebx, %rbx
               	movslq	0x8c(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	subq	$0x70, %rsp
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	0x288(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x280(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x278(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x270(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x268(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x260(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x258(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x250(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbx, 0x60(%rsp)
               	movq	%rax, 0x68(%rsp)
               	callq	<addr>
               	addq	$0x70, %rsp
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	ud2
