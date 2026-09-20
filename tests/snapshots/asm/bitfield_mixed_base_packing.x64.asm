
bitfield_mixed_base_packing.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	orq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	movl	%ecx, (%rax)
               	movzbq	0x3(%rax), %rcx
               	andq	$-0x81, %rcx
               	orq	$0x80, %rcx
               	movb	%cl, 0x3(%rax)
               	movl	0x4(%rax), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x3fffffff, %rdx       # imm = 0x3FFFFFFF
               	movl	%edx, 0x4(%rax)
               	movzbq	0x7(%rax), %rdx
               	andq	$-0xc1, %rdx
               	orq	$0xc0, %rdx
               	movb	%dl, 0x7(%rax)
               	movl	$0xdeadbeef, 0x8(%rax)  # imm = 0xDEADBEEF
               	movb	$-0x55, 0xc(%rax)
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	sarq	$0x7, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	cmpl	$0x3fffffff, %ecx       # imm = 0x3FFFFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x6, %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	(%rax), %edx
               	andq	$-0x80000000, %rdx      # imm = 0x80000000
               	movl	%edx, (%rax)
               	andq	$-0xc1, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x200, %rcx           # imm = 0xFE00
               	orq	$0x1ff, %rcx            # imm = 0x1FF
               	movw	%cx, (%rax)
               	movzwq	0x2(%rax), %rdx
               	andq	$-0x200, %rdx           # imm = 0xFE00
               	orq	$0x123, %rdx            # imm = 0x123
               	movw	%dx, 0x2(%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x1ff, %eax            # imm = 0x1FF
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x123, %eax            # imm = 0x123
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
