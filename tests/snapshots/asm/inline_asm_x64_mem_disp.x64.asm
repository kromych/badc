
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	leaq	<rip>, %rdx
               	leaq	0x40(%rdx), %rdx
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	%rcx, -0x10(%rdx)
               	movq	%rcx, 0x100(%rdx)
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x48(%rax), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0x30(%rax), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0x140(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	0x40(%rbx), %rbx
               	movq	0x8(%rbx), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	leaq	<rip>, %rdx
               	leaq	0x80(%rdx), %rdx
               	movabsq	$-0x5544332211663502, %rcx # imm = 0xAABBCCDDEE99CAFE
               	movl	%ecx, (%rdx)
               	movw	%cx, 0x8(%rdx)
               	movb	%cl, 0x10(%rdx)
               	movq	(%rax), %rax
               	movl	$0xee99cafe, %r11d      # imm = 0xEE99CAFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x88(%rax), %rcx
               	cmpq	$0xcafe, %rcx           # imm = 0xCAFE
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0x90(%rax), %rcx
               	cmpq	$0xfe, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x100(%rax), %rcx
               	leaq	<rip>, %rax
               	leaq	0x100(%rax), %rax
               	movabsq	$-0xff20ff20ff20ff3, %rbx # imm = 0xF00DF00DF00DF00D
               	movq	%rax, %r12
               	movq	%rax, %r13
               	movq	%rbx, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movq	%rbx, 0x10(%r13)
               	movq	%rbx, -0x8(%r13)
               	movq	(%rcx), %rax
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x108(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0x110(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	0xf8(%rax), %rcx
               	movabsq	$-0xff20ff20ff20ff3, %r11 # imm = 0xF00DF00DF00DF00D
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	addq	$0x40, %rax
               	leaq	<rip>, %rdx
               	leaq	0x40(%rdx), %rdx
               	addq	$0x5, (%rdx)
               	movq	(%rax), %rax
               	movabsq	$0x112233445566778d, %r11 # imm = 0x112233445566778D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rax)
               	movq	(%rcx), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
