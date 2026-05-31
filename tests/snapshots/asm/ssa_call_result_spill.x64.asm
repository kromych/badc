
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movl	$0xe, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x12, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	xorq	%rax, %r14
               	movl	$0x29, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rax, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
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
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	-0x28(%rbp), %r14
               	movq	-0x30(%rbp), %rbx
               	movq	-0x38(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%rax, %r12
               	movq	-0x40(%rbp), %rax
               	addq	%rax, %r12
               	movq	%r12, -0x50(%rbp)
               	movq	-0x8(%rbp), %r14
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	-0x28(%rbp), %r14
               	movq	%r14, -0x30(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x50(%rbp), %r14
               	addq	%r14, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x18(%rbp), %r15
               	movq	%r15, -0x20(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x8(%rbp), %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x58(%rbp), %rax
               	addq	%rax, %r14
               	movq	%r14, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r14
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	cmpq	%r11, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	-0x40(%rbp), %r14
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	cmpq	%r11, %r14
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
