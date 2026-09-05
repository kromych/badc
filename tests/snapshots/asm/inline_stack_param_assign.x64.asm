
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
               	movq	%rax, %rsi
               	movswq	%si, %rsi
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
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
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%rax)
               	movq	0x28(%rbp), %rax
               	movsbq	0x10(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, 0x28(%rbp)
               	movl	0x30(%rbp), %edx
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rsi
               	movzwq	0x18(%rbp), %rdi
               	addq	%rdi, %rsi
               	movslq	0x20(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rax
               	movl	%edx, %edx
               	addq	%rdx, %rax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movabsq	$-0x7, %rcx
               	movl	$0x186a0, %esi          # imm = 0x186A0
               	movl	$0xb2d05e00, %edi       # imm = 0xB2D05E00
               	movq	%rcx, -0x10(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	leaq	0x9(%rax), %rsi
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rdx), %rdi
               	subq	$0x12c, %rdi            # imm = 0x12C
               	movq	%rdi, (%rdx)
               	movq	-0x18(%rbp), %rdx
               	movsbq	-0x10(%rbp), %rdi
               	addq	%rdi, %rdx
               	movq	%rdx, -0x18(%rbp)
               	movl	-0x8(%rbp), %edi
               	movslq	%esi, %rsi
               	addq	$0x64b, %rsi            # imm = 0x64B
               	addq	%rsi, %rdx
               	movl	%edi, %esi
               	addq	%rsi, %rdx
               	addq	$0x9c40, %rdx           # imm = 0x9C40
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2, %esi
               	movl	$0x12c, %edi            # imm = 0x12C
               	movl	$0x9c40, %r8d           # imm = 0x9C40
               	movabsq	$-0x32, %r9
               	movl	$0x3c, %ebx
               	movl	$0x320, %r12d           # imm = 0x320
               	movl	$0x9, %r13d
               	movl	$0x186a0, %r14d         # imm = 0x186A0
               	movl	$0xb2d05e00, %r15d      # imm = 0xB2D05E00
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x30, %rsp
               	movq	%rcx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %rdx
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movq	%rax, %rdi
               	movq	%rbx, %r9
               	movq	0x30(%rsp), %r10
               	callq	*%r10
               	addq	$0x30, %rsp
               	addq	$0x10, %rsp
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
