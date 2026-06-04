
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	movl	$0x40, %esi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	shlq	%cl, %rax
               	orq	%rdx, %rax
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	retq
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	rorq	$0xe, %rcx
               	movq	%rax, %rdx
               	rorq	$0x12, %rdx
               	xorq	%rdx, %rcx
               	rorq	$0x29, %rax
               	xorq	%rcx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x100, %r10d           # imm = 0x100
               	movq	%r10, 0x30(%rsp)
               	movl	$0x200, %r10d           # imm = 0x200
               	movq	%r10, 0x38(%rsp)
               	movl	$0x400, %r10d           # imm = 0x400
               	movq	%r10, 0x40(%rsp)
               	movl	$0x800, %r10d           # imm = 0x800
               	movq	%r10, 0x48(%rsp)
               	movl	$0x1000, %r15d          # imm = 0x1000
               	movl	$0x2000, %r14d          # imm = 0x2000
               	movl	$0x4000, %r12d          # imm = 0x4000
               	movl	$0x8000, %ebx           # imm = 0x8000
               	xorq	%rax, %rax
               	movl	%eax, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	movq	%r12, %rbx
               	movq	%r14, %r12
               	movq	%r15, %r14
               	movq	%rdx, %r15
               	movq	0x40(%rsp), %r13
               	movq	%r13, 0x48(%rsp)
               	movq	0x38(%rsp), %r13
               	movq	%r13, 0x40(%rsp)
               	movq	0x30(%rsp), %r13
               	movq	%r13, 0x38(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	jmp	<addr>
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rax, %rbx
               	movq	0x30(%rsp), %rdi
               	callq	<addr>
               	movq	0x48(%rsp), %rdx
               	addq	%rbx, %rdx
               	movq	%rbx, %rsi
               	addq	%rax, %rsi
               	jmp	<addr>
               	movq	0x30(%rsp), %rax
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
