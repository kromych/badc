
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %edi
               	subq	%r9, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r8, %rax
               	orq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%rdx, %r8
               	andq	%r11, %r9
               	xorq	$-0x1, %r11
               	andq	%r8, %r11
               	movq	%r9, %rax
               	xorq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%r11, %r9
               	rorq	$0xe, %r9
               	movq	%r11, %r8
               	rorq	$0x12, %r8
               	xorq	%r8, %r9
               	rorq	$0x29, %r11
               	movq	%r9, %rax
               	xorq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movl	$0x100, %r11d           # imm = 0x100
               	movq	%r11, -0x8(%rbp)
               	movl	$0x200, %r9d            # imm = 0x200
               	movq	%r9, -0x10(%rbp)
               	movl	$0x400, %r11d           # imm = 0x400
               	movq	%r11, -0x18(%rbp)
               	movl	$0x800, %r9d            # imm = 0x800
               	movq	%r9, -0x20(%rbp)
               	movl	$0x1000, %r11d          # imm = 0x1000
               	movq	%r11, -0x28(%rbp)
               	movl	$0x2000, %r9d           # imm = 0x2000
               	movq	%r9, -0x30(%rbp)
               	movl	$0x4000, %r11d          # imm = 0x4000
               	movq	%r11, -0x38(%rbp)
               	movl	$0x8000, %r9d           # imm = 0x8000
               	movq	%r9, -0x40(%rbp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movq	-0x28(%rbp), %r11
               	movq	%r11, %r8
               	rorq	$0xe, %r8
               	movq	%r11, %r9
               	rorq	$0x12, %r9
               	xorq	%r9, %r8
               	rorq	$0x29, %r11
               	xorq	%r11, %r8
               	movq	-0x28(%rbp), %r11
               	movq	-0x30(%rbp), %r9
               	movq	-0x38(%rbp), %rdi
               	andq	%r11, %r9
               	xorq	$-0x1, %r11
               	andq	%rdi, %r11
               	xorq	%r11, %r9
               	addq	%r9, %r8
               	movq	-0x40(%rbp), %r9
               	addq	%r9, %r8
               	movq	%r8, -0x50(%rbp)
               	movq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	rorq	$0xe, %r8
               	movq	%r9, %r11
               	rorq	$0x12, %r11
               	xorq	%r11, %r8
               	rorq	$0x29, %r9
               	xorq	%r9, %r8
               	movq	%r8, -0x58(%rbp)
               	movq	-0x38(%rbp), %r9
               	movq	%r9, -0x40(%rbp)
               	movq	-0x30(%rbp), %r8
               	movq	%r8, -0x38(%rbp)
               	movq	-0x28(%rbp), %r9
               	movq	%r9, -0x30(%rbp)
               	movq	-0x20(%rbp), %r8
               	movq	-0x50(%rbp), %r9
               	addq	%r9, %r8
               	movq	%r8, -0x28(%rbp)
               	movq	-0x18(%rbp), %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x10(%rbp), %r8
               	movq	%r8, -0x18(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	%r11, -0x10(%rbp)
               	movq	-0x58(%rbp), %r8
               	addq	%r8, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	-0x40(%rbp), %r9
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
