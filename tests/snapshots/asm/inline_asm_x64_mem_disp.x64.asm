
inline_asm_x64_mem_disp.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	<rip>, %rsi
               	leaq	0x40(%rsi), %rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	%rcx, -0x10(%rdx)
               	movq	%rcx, 0x100(%rdx)
               	movq	(%rax), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x48(%rsi), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x30(%rsi), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x140(%rsi), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	movq	0x8(%rbx), %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	0x80(%rsi), %rax
               	movabsq	$-0x5544332211663502, %rcx # imm = 0xAABBCCDDEE99CAFE
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rcx
               	movl	%ecx, (%rdx)
               	movw	%cx, 0x8(%rdx)
               	movb	%cl, 0x10(%rdx)
               	movq	(%rax), %rax
               	movl	$0xee99cafe, %r11d      # imm = 0xEE99CAFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x88(%rsi), %rax
               	cmpq	$0xcafe, %rax           # imm = 0xCAFE
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	0x90(%rsi), %rax
               	cmpq	$0xfe, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	0x100(%rsi), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %rax # imm = 0xF00DF00DF00DF00D
               	movq	%rbx, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	movq	%r13, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rbx
               	movq	%rax, %r12
               	movq	%rax, %r13
               	movq	%rbx, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movq	%rbx, 0x10(%r13)
               	movq	%rbx, -0x8(%r13)
               	movq	-0x40(%rbp), %rbx
               	movq	-0x38(%rbp), %r12
               	movq	-0x30(%rbp), %r13
               	movq	(%rcx), %rax
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	0x108(%rsi), %rax
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	0x110(%rsi), %rax
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	0xf8(%rsi), %rax
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	0x40(%rsi), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x40(%rbp), %rdx
               	addq	$0x5, (%rdx)
               	movq	(%rax), %rax
               	movabsq	$0x112233445566778d, %r11 # imm = 0x112233445566778D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, (%rax)
               	movq	(%rcx), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
