
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
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %eax
               	andq	$-0x100, %rax
               	orq	$0xab, %rax
               	movl	%eax, -0x18(%rbp)
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	orq	$0x100, %rax            # imm = 0x100
               	movl	%eax, -0x18(%rbp)
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rax
               	orq	$0x2468a00, %rax        # imm = 0x2468A00
               	movl	%eax, -0x18(%rbp)
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xab, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	sarq	$0x9, %rcx
               	cmpl	$0x12345, %ecx          # imm = 0x12345
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	andq	$-0x100, %rax
               	orq	$0x55, %rax
               	movl	%eax, -0x18(%rbp)
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x55, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	sarq	$0x9, %rax
               	cmpl	$0x12345, %eax          # imm = 0x12345
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0xff, %rcx
               	movl	%ecx, (%rax)
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	orq	$0x100, %rcx            # imm = 0x100
               	movl	%ecx, (%rax)
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	movl	$0xfffffe00, %r11d      # imm = 0xFFFFFE00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	andq	$-0x100, %rcx
               	movl	%ecx, 0x4(%rax)
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	movl	%ecx, 0x4(%rax)
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	movl	%ecx, 0x4(%rax)
               	testb	$-0x1, %cl
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	%ecx, %eax
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	sarq	$0x9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
