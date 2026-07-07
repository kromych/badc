
bitfield_storage_unit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	leaq	-0x10(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x10(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0xab, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	orq	$0x100, %rcx            # imm = 0x100
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	orq	$0x2468a00, %rcx        # imm = 0x2468A00
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0xff, %rax
               	cmpq	$0xab, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	cmpq	$0x12345, %rax          # imm = 0x12345
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0x55, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0xff, %rax
               	cmpq	$0x55, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	cmpq	$0x12345, %rax          # imm = 0x12345
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0xff, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x101, %rcx           # imm = 0xFEFF
               	orq	$0x100, %rcx            # imm = 0x100
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rcx
               	movl	$0xfffffe00, %r11d      # imm = 0xFFFFFE00
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	0x4(%rax), %edx
               	andq	$-0x100, %rdx
               	orq	%rcx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %edx
               	andq	$-0x101, %rdx           # imm = 0xFEFF
               	orq	%rcx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %edx
               	movabsq	$-0xfffffe01, %r11      # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %eax
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %eax
               	sarq	$0x9, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
