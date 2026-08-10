
inline_asm_x64_mem_disp.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	<rip>, %rax
               	leaq	0x40(%rax), %rcx
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rdx
               	movq	-0x28(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	%rcx, -0x10(%rdx)
               	movq	%rcx, 0x100(%rdx)
               	movq	-0x40(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	movq	(%rcx), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x48(%rax), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x30(%rax), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x140(%rax), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	0x8(%rbx), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x10(%rbp), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x80(%rax), %rcx
               	movabsq	$-0x5544332211663502, %rdx # imm = 0xAABBCCDDEE99CAFE
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rdx
               	movq	-0x28(%rbp), %rcx
               	movl	%ecx, (%rdx)
               	movw	%cx, 0x8(%rdx)
               	movb	%cl, 0x10(%rdx)
               	movq	-0x40(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	movq	(%rcx), %rcx
               	movl	$0xee99cafe, %r11d      # imm = 0xEE99CAFE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x88(%rax), %rcx
               	cmpq	$0xcafe, %rcx           # imm = 0xCAFE
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x90(%rax), %rcx
               	cmpq	$0xfe, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x100(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %rdx # imm = 0xF00DF00DF00DF00D
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%r12, -0x30(%rbp)
               	movq	%r13, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	movq	%rax, %r12
               	movq	%rax, %r13
               	movq	%rbx, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movq	%rbx, 0x10(%r13)
               	movq	%rbx, -0x8(%r13)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x30(%rbp), %r12
               	movq	-0x28(%rbp), %r13
               	movq	(%rcx), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x108(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x110(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0xf8(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x40, %rax
               	movq	%rdx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rdx
               	addq	$0x5, (%rdx)
               	movq	-0x40(%rbp), %rdx
               	movq	(%rax), %rax
               	movabsq	$0x112233445566778d, %r11 # imm = 0x112233445566778D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, (%rax)
               	movq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
