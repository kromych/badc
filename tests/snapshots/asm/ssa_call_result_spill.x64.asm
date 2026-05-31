
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
               	movq	%r11, %rdi
               	andq	%r9, %rdi
               	xorq	$-0x1, %r11
               	andq	%r8, %r11
               	movq	%rdi, %rax
               	xorq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movl	$0xe, %r9d
               	movq	%r11, %r8
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %edi
               	subq	%r9, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %r9
               	movq	%rdi, %rcx
               	shlq	%cl, %r9
               	orq	%r9, %r8
               	movl	$0x12, %r9d
               	movq	%r11, %rdi
               	movq	%r9, %rcx
               	shrq	%cl, %rdi
               	movl	$0x40, %esi
               	subq	%r9, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %r9
               	movq	%rsi, %rcx
               	shlq	%cl, %r9
               	orq	%r9, %rdi
               	xorq	%rdi, %r8
               	movl	$0x29, %edi
               	movq	%r11, %r9
               	movq	%rdi, %rcx
               	shrq	%cl, %r9
               	movl	$0x40, %esi
               	subq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rcx
               	shlq	%cl, %r11
               	orq	%r11, %r9
               	movq	%r8, %rax
               	xorq	%r9, %rax
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
               	movl	$0xe, %r8d
               	movq	%r11, %r9
               	movq	%r8, %rcx
               	shrq	%cl, %r9
               	movl	$0x40, %edi
               	subq	%r8, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %r8
               	movq	%rdi, %rcx
               	shlq	%cl, %r8
               	orq	%r8, %r9
               	movl	$0x12, %r8d
               	movq	%r11, %rdi
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	movl	$0x40, %esi
               	subq	%r8, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %r8
               	movq	%rsi, %rcx
               	shlq	%cl, %r8
               	orq	%r8, %rdi
               	xorq	%rdi, %r9
               	movl	$0x29, %edi
               	movq	%r11, %r8
               	movq	%rdi, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %esi
               	subq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rcx
               	shlq	%cl, %r11
               	orq	%r11, %r8
               	xorq	%r8, %r9
               	movq	-0x28(%rbp), %r8
               	movq	-0x30(%rbp), %r11
               	movq	-0x38(%rbp), %rsi
               	movq	%r8, %rdi
               	andq	%r11, %rdi
               	xorq	$-0x1, %r8
               	andq	%rsi, %r8
               	xorq	%r8, %rdi
               	addq	%rdi, %r9
               	movq	-0x40(%rbp), %rdi
               	addq	%rdi, %r9
               	movq	%r9, -0x50(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movl	$0xe, %r9d
               	movq	%rdi, %r8
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %esi
               	subq	%r9, %rsi
               	movslq	%esi, %rsi
               	movq	%rdi, %r9
               	movq	%rsi, %rcx
               	shlq	%cl, %r9
               	orq	%r9, %r8
               	movl	$0x12, %r9d
               	movq	%rdi, %rsi
               	movq	%r9, %rcx
               	shrq	%cl, %rsi
               	movl	$0x40, %r11d
               	subq	%r9, %r11
               	movslq	%r11d, %r11
               	movq	%rdi, %r9
               	movq	%r11, %rcx
               	shlq	%cl, %r9
               	orq	%r9, %rsi
               	xorq	%rsi, %r8
               	movl	$0x29, %esi
               	movq	%rdi, %r9
               	movq	%rsi, %rcx
               	shrq	%cl, %r9
               	movl	$0x40, %r11d
               	subq	%rsi, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %rcx
               	shlq	%cl, %rdi
               	orq	%rdi, %r9
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
               	movq	-0x18(%rbp), %rdi
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x10(%rbp), %r8
               	movq	%r8, -0x18(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
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
