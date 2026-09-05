
bitfield_storage_unit.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	0x8(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0xab, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	orq	$0x100, %rcx            # imm = 0x100
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	orq	$0x2468a00, %rcx        # imm = 0x2468A00
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xab, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x9, %rsi
               	andq	$0x7fffff, %rsi         # imm = 0x7FFFFF
               	cmpl	$0x12345, %esi          # imm = 0x12345
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	%rdx, %rcx
               	andq	$-0x100, %rcx
               	orq	$0x55, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0x55, %esi
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rdx, %rcx
               	sarq	$0x9, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	cmpl	$0x12345, %ecx          # imm = 0x12345
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0xff, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	orq	$0x100, %rcx            # imm = 0x100
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, %ecx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	movl	$0xfffffe00, %r11d      # imm = 0xFFFFFE00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movl	0x4(%rax), %edx
               	andq	$-0x100, %rdx
               	orq	%rcx, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	%edx, %edx
               	andq	$-0x101, %rdx           # imm = 0xFEFF
               	orq	%rcx, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	%edx, %edx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rdx
               	orq	%rcx, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	%edx, %eax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	%rax, %rsi
               	sarq	$0x8, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	sarq	$0x9, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
