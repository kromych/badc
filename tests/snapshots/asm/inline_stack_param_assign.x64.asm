
inline_stack_param_assign.x64:	file format elf64-x86-64

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

<mash_outline>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movswq	%r8w, %r8
               	movq	%r8, %rax
               	subq	%rsi, %rax
               	movswq	%ax, %rsi
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	addq	$0x3, %rax
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	movzwq	0x18(%rbp), %rax
               	shlq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x18(%rbp)
               	movslq	0x20(%rbp), %rax
               	addq	%rdi, %rax
               	movl	%eax, 0x20(%rbp)
               	leaq	0x28(%rbp), %rax
               	movq	(%rax), %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, (%rax)
               	movq	0x28(%rbp), %rax
               	movsbq	0x10(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, 0x28(%rbp)
               	movl	0x30(%rbp), %edx
               	addq	%r8, %rsi
               	movzwq	0x18(%rbp), %rdi
               	addq	%rdi, %rsi
               	movslq	0x20(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	movq	$-0x7, %rax
               	movl	$0xb2d05e00, %edx       # imm = 0xB2D05E00
               	movq	%rax, -0x10(%rbp)
               	movq	$0x186a0, -0x18(%rbp)   # imm = 0x186A0
               	movq	%rdx, -0x8(%rbp)
               	leaq	0x9(%rdi), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rsi
               	subq	$0x12c, %rsi            # imm = 0x12C
               	movq	%rsi, (%rcx)
               	movq	-0x18(%rbp), %rcx
               	movsbq	-0x10(%rbp), %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, -0x18(%rbp)
               	movl	-0x8(%rbp), %esi
               	movslq	%edx, %rdx
               	addq	$0x64b, %rdx            # imm = 0x64B
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	$0x9c40, %rcx           # imm = 0x9C40
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %esi
               	movl	$0x12c, %edx            # imm = 0x12C
               	movl	$0x9c40, %ecx           # imm = 0x9C40
               	movq	$-0x32, %r8
               	movl	$0x3c, %r9d
               	movl	$0x320, %ebx            # imm = 0x320
               	movl	$0x9, %r12d
               	movl	$0x186a0, %r13d         # imm = 0x186A0
               	movl	$0xb2d05e00, %r14d      # imm = 0xB2D05E00
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	0x30(%rsp), %r10
               	callq	*%r10
               	addq	$0x30, %rsp
               	addq	$0x10, %rsp
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
