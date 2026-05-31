
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0xa8(%rbp)
               	jmp	<addr>
               	movslq	-0xa8(%rbp), %r9
               	cmpq	$0x28, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xa8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %r9
               	movslq	-0xa8(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r9
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	movl	%edi, (%r9)
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x68(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	movq	0x10(%r9), %rax
               	movq	%rax, 0x10(%r11)
               	movq	0x18(%r9), %rax
               	movq	%rax, 0x18(%r11)
               	movq	0x20(%r9), %rax
               	movq	%rax, 0x20(%r11)
               	movq	0x28(%r9), %rax
               	movq	%rax, 0x28(%r11)
               	movq	0x30(%r9), %rax
               	movq	%rax, 0x30(%r11)
               	movq	0x38(%r9), %rax
               	movq	%rax, 0x38(%r11)
               	movq	0x40(%r9), %rax
               	movq	%rax, 0x40(%r11)
               	movq	0x48(%r9), %rax
               	movq	%rax, 0x48(%r11)
               	movq	0x50(%r9), %rax
               	movq	%rax, 0x50(%r11)
               	movq	0x58(%r9), %rax
               	movq	%rax, 0x58(%r11)
               	movzbq	0x60(%r9), %rax
               	movb	%al, 0x60(%r11)
               	movzbq	0x61(%r9), %rax
               	movb	%al, 0x61(%r11)
               	movzbq	0x62(%r9), %rax
               	movb	%al, 0x62(%r11)
               	movzbq	0x63(%r9), %rax
               	movb	%al, 0x63(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	xorq	%r8, %r8
               	movl	%r8d, -0x70(%rbp)
               	movl	%r8d, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x19, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r8
               	movl	(%r8), %r11d
               	leaq	-0x68(%rbp), %r9
               	movslq	-0x78(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r9
               	movl	(%r9), %r9d
               	addq	%r9, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	movl	-0x70(%rbp), %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x12345678, %r14d      # imm = 0x12345678
               	movq	%r14, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
