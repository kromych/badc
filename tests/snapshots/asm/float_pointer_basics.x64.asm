
float_pointer_basics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4, %r11d
               	movl	$0x8, %r9d
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%r9d, %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %ebx
               	movslq	%ebx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	movslq	%ebx, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r15
               	movl	$0x3f800000, %ebx       # imm = 0x3F800000
               	movl	%ebx, (%r14)
               	movq	%r14, %rdi
               	addq	$0x4, %rdi
               	movl	$0x40000000, %ebx       # imm = 0x40000000
               	movl	%ebx, (%rdi)
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, (%r15)
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, (%rbx)
               	movslq	(%r14), %rdi
               	cmpq	$0x3f800000, %rdi       # imm = 0x3F800000
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%r15), %rax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdi
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
