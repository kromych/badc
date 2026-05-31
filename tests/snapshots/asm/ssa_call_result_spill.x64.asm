
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40030f <.text+0xef>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %edi
               	movq	%rdi, %rsi
               	subq	%r9, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdi
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%rdx, %r8
               	movq	%r11, %rdi
               	andq	%r9, %rdi
               	movq	%r11, %r9
               	xorq	$-0x1, %r9
               	movq	%r9, %r11
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
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r14
               	movl	$0x12, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%r14, %r12
               	xorq	%rax, %r12
               	movl	$0x29, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%r12, %r15
               	xorq	%rax, %r15
               	movq	%r15, %rcx
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
               	jmp	0x400389 <.text+0x169>
               	movslq	-0x48(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	0x40045a <.text+0x23a>
               	jmp	0x4003b8 <.text+0x198>
               	leaq	-0x48(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400389 <.text+0x169>
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x40028a <.text+0x6a>
               	movq	%rax, %r12
               	movq	-0x28(%rbp), %r14
               	movq	-0x30(%rbp), %rbx
               	movq	-0x38(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	0x400264 <.text+0x44>
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movq	-0x40(%rbp), %rax
               	movq	%r15, %r12
               	addq	%rax, %r12
               	movq	%r12, -0x50(%rbp)
               	movq	-0x8(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x40028a <.text+0x6a>
               	movq	%rax, -0x58(%rbp)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	-0x28(%rbp), %r14
               	movq	%r14, -0x30(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x50(%rbp), %r14
               	movq	%rax, %r15
               	addq	%r14, %r15
               	movq	%r15, -0x28(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x10(%rbp), %r15
               	movq	%r15, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x58(%rbp), %r15
               	movq	%r14, %rax
               	addq	%r15, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	0x40039f <.text+0x17f>
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	movq	%rax, %r15
               	cmpq	%r11, %rax
               	je	0x40049b <.text+0x27b>
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
               	movq	-0x40(%rbp), %r15
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%r15, %rax
               	cmpq	%r11, %r15
               	je	0x4004dd <.text+0x2bd>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
