
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
               	movl	-0x10(%rbp), %eax
               	andq	$-0x80000000, %rax      # imm = 0x80000000
               	orq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	movl	%eax, -0x10(%rbp)
               	movzbq	-0xd(%rbp), %rax
               	andq	$-0x81, %rax
               	orq	$0x80, %rax
               	movb	%al, -0xd(%rbp)
               	movl	-0xc(%rbp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	movl	%ecx, -0xc(%rbp)
               	movzbq	-0x9(%rbp), %rcx
               	andq	$-0xc1, %rcx
               	orq	$0xc0, %rcx
               	movb	%cl, -0x9(%rbp)
               	movl	$0xdeadbeef, -0x8(%rbp) # imm = 0xDEADBEEF
               	movb	$-0x55, -0x4(%rbp)
               	movl	-0x10(%rbp), %edx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	cmpl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	andq	$0xff, %rax
               	sarq	$0x7, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0xc(%rbp), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	cmpl	$0x3fffffff, %eax       # imm = 0x3FFFFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rcx
               	sarq	$0x6, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %ecx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	%ecx, -0x10(%rbp)
               	andq	$-0xc1, %rax
               	movb	%al, -0x9(%rbp)
               	xorl	%eax, %eax
               	leave
               	retq
