
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
               	subq	%rsi, %r8
               	movswq	%r8w, %rsi
               	andq	$0xff, %r9
               	leaq	0x3(%r9), %rax
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	movzwq	0x18(%rbp), %rax
               	shlq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x18(%rbp)
               	movl	0x20(%rbp), %eax
               	addq	%rdi, %rax
               	movl	%eax, 0x20(%rbp)
               	movslq	%eax, %rdi
               	movq	0x28(%rbp), %rax
               	subq	%rdx, %rax
               	movq	%rax, 0x28(%rbp)
               	movsbq	0x10(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, 0x28(%rbp)
               	movl	0x30(%rbp), %edx
               	addq	%r8, %rsi
               	movzwq	0x18(%rbp), %r8
               	addq	%r8, %rsi
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
               	subq	$0x30, %rsp
               	movl	<rip>, %edi # <addr>
               	movq	$-0x7, %rax
               	movl	$0xb2d05e00, %ecx       # imm = 0xB2D05E00
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	leaq	0x9(%rdi), %rcx
               	movsbq	-0x10(%rbp), %rdx
               	addq	$0x18574, %rdx          # imm = 0x18574
               	movl	-0x8(%rbp), %esi
               	movslq	%ecx, %rcx
               	addq	$0x64b, %rcx            # imm = 0x64B
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	$0x9c40, %rcx           # imm = 0x9C40
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2, %esi
               	movl	$0x12c, %edx            # imm = 0x12C
               	movl	$0x9c40, %ecx           # imm = 0x9C40
               	movq	$-0x32, %r8
               	movl	$0x3c, %r9d
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x8(%rsp)
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	$0x320, 0x8(%rsp)       # imm = 0x320
               	movq	$0x9, 0x10(%rsp)
               	movq	$0x186a0, 0x18(%rsp)    # imm = 0x186A0
               	movl	$0xb2d05e00, %r10d      # imm = 0xB2D05E00
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rsp), %r10
               	callq	*%r10
               	addq	$0x30, %rsp
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
