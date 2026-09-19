
inline_asm_x64_operand_modifiers.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x8002, %eax           # imm = 0x8002
               	movw	%ax, -0x10(%rbp)
               	movl	$0x81, %eax
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	shrb	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x40, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8001, %eax           # imm = 0x8001
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	shrw	%ax
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x4000, %rax           # imm = 0x4000
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	shrl	%eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x40000000, %eax       # imm = 0x40000000
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	shrw	(%rax)
               	movzwq	-0x10(%rbp), %rax
               	xorq	$0x4001, %rax           # imm = 0x4001
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	movb	%dh, %al
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	andq	$0xff, %rax
               	xorq	$0x56, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000040, %r8d       # imm = 0x80000040
               	movl	%r8d, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0x80000040, %r11d      # imm = 0x80000040
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1e, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0xc, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x23, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x7, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x27, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x3, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x28, %ebx
               	addq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shlq	$0x3, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shlq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
