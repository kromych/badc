
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
               	popq	%r10
               	subq	$0xb0, %rsp
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xc8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0xd0(%rsp), %rax
               	movq	%rax, 0xa0(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movswq	%r8w, %r8
               	movq	%r8, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rsi
               	movswq	%si, %rsi
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	movzwq	0x80(%rbp), %rax
               	shlq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x80(%rbp)
               	movslq	0x90(%rbp), %rax
               	addq	%rdi, %rax
               	movl	%eax, 0x90(%rbp)
               	leaq	0xa0(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%rax)
               	movq	0xa0(%rbp), %rax
               	movsbq	0x70(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, 0xa0(%rbp)
               	movl	0xb0(%rbp), %edx
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rsi
               	movzwq	0x80(%rbp), %rdi
               	addq	%rdi, %rsi
               	movslq	0x90(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rax
               	movl	%edx, %edx
               	addq	%rdx, %rax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
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
               	movabsq	$-0x7, %rdx
               	movl	$0x186a0, %esi          # imm = 0x186A0
               	movl	$0xb2d05e00, %edi       # imm = 0xB2D05E00
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	leaq	0x9(%rax), %rdx
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
               	movl	%esi, %edx
               	addq	%rdx, %rcx
               	addq	$0x9c40, %rcx           # imm = 0x9C40
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %esi
               	movl	$0x12c, %edx            # imm = 0x12C
               	movl	$0x9c40, %edi           # imm = 0x9C40
               	movabsq	$-0x32, %r8
               	movl	$0x3c, %r9d
               	movabsq	$-0x7, %rbx
               	movl	$0x320, %r12d           # imm = 0x320
               	movl	$0x9, %r13d
               	movl	$0x186a0, %r14d         # imm = 0x186A0
               	movl	$0xb2d05e00, %r15d      # imm = 0xB2D05E00
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %rcx
               	movq	%rax, %rdi
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
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
