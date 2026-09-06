
inline_asm_x64_imm_mem.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	xorb	$-0x80, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667708, %r11 # imm = 0x1122334455667708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	addb	$0x8, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667710, %r11 # imm = 0x1122334455667710
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	orb	$0xf, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x112233445566771f, %r11 # imm = 0x112233445566771F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	andb	$-0x10, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667710, %r11 # imm = 0x1122334455667710
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	subb	$0x10, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667700, %r11 # imm = 0x1122334455667700
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	stc
               	adcb	$0x0, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667701, %r11 # imm = 0x1122334455667701
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	stc
               	sbbb	$0x0, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455667700, %r11 # imm = 0x1122334455667700
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movb	$0x2a, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x112233445566772a, %r11 # imm = 0x112233445566772A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	xorw	$0x8000, (%rax)         # imm = 0x8000
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x112233445566f72a, %r11 # imm = 0x112233445566F72A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	addw	$0x2, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x112233445566f72c, %r11 # imm = 0x112233445566F72C
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movw	$0x2a2a, (%rax)         # imm = 0x2A2A
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455662a2a, %r11 # imm = 0x1122334455662A2A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	testb	$0x1, (%rbx)
               	sete	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	cmpb	$0x2a, (%rbx)
               	sete	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x80, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	xorb	%bl, (%rax)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x1122334455662aaa, %r11 # imm = 0x1122334455662AAA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
