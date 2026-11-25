
inline_stack_param_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movswq	%r8w, %r8
               	subq	%rsi, %r8
               	movswq	%r8w, %r10
               	andq	$0xff, %r9
               	leaq	0x3(%r9), %r8
               	andq	$0xff, %r8
               	movzwq	0x10(%rsp), %rax
               	shlq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x10(%rsp)
               	movl	0x18(%rsp), %esi
               	addq	%rdi, %rsi
               	movl	%esi, 0x18(%rsp)
               	movslq	%esi, %rdi
               	movq	0x20(%rsp), %rsi
               	subq	%rdx, %rsi
               	movq	%rsi, 0x20(%rsp)
               	movsbq	0x8(%rsp), %rdx
               	addq	%rsi, %rdx
               	movq	%rdx, 0x20(%rsp)
               	movl	0x28(%rsp), %esi
               	addq	%r10, %r8
               	addq	%r8, %rax
               	addq	%rdi, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movl	<rip>, %edi # <addr>
               	movq	$-0x7, %rax
               	movl	$0xb2d05e00, %ecx       # imm = 0xB2D05E00
               	movq	%rax, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	leaq	0x9(%rdi), %rcx
               	movsbq	0x50(%rsp), %rdx
               	addq	$0x18574, %rdx          # imm = 0x18574
               	movl	0x58(%rsp), %esi
               	movslq	%ecx, %rcx
               	addq	$0x64b, %rcx            # imm = 0x64B
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	$0x9c40, %rcx           # imm = 0x9C40
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x2, %esi
               	movl	$0x12c, %edx            # imm = 0x12C
               	movl	$0x9c40, %ecx           # imm = 0x9C40
               	movq	$-0x32, %r8
               	movl	$0x3c, %r9d
               	movq	<rip>, %rbx # <addr>
               	movq	%rax, (%rsp)
               	movq	$0x320, 0x8(%rsp)       # imm = 0x320
               	movq	$0x9, 0x10(%rsp)
               	movq	$0x186a0, 0x18(%rsp)    # imm = 0x186A0
               	movl	$0xb2d05e00, %r10d      # imm = 0xB2D05E00
               	movq	%r10, 0x20(%rsp)
               	callq	*%rbx
               	movl	$0xb2d28602, %r11d      # imm = 0xB2D28602
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
