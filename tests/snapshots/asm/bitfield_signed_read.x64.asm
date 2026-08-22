
bitfield_signed_read.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x4, %rcx
               	orq	$0x3, %rcx
               	movw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xd, %rcx
               	orq	$0x4, %rcx
               	movw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xfff1, %rcx          # imm = 0xFFFF000F
               	orq	$0x8000, %rcx           # imm = 0x8000
               	movw	%cx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	andq	$0x3, %rsi
               	shlq	$0x3e, %rsi
               	sarq	$0x3e, %rsi
               	cmpq	$-0x1, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x2, %rsi
               	andq	$0x3, %rsi
               	shlq	$0x3e, %rsi
               	sarq	$0x3e, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	sarq	$0x4, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	shlq	$0x34, %rdx
               	sarq	$0x34, %rdx
               	cmpq	$-0x800, %rdx           # imm = 0xF800
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	(%rax), %ecx
               	andq	$-0x8, %rcx
               	orq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x7f9, %rcx           # imm = 0xF807
               	orq	$0x400, %rcx            # imm = 0x400
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	movabsq	$-0xfffff801, %r11      # imm = 0xFFFFFFFF000007FF
               	andq	%r11, %rcx
               	movl	$0xfffff800, %r11d      # imm = 0xFFFFF800
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	andq	$0x7, %rsi
               	shlq	$0x3d, %rsi
               	sarq	$0x3d, %rsi
               	cmpq	$-0x4, %rsi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x3, %rsi
               	andq	$0xff, %rsi
               	movsbq	%sil, %rsi
               	cmpq	$-0x80, %rsi
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	sarq	$0xb, %rdx
               	andq	$0x1fffff, %rdx         # imm = 0x1FFFFF
               	shlq	$0x2b, %rdx
               	sarq	$0x2b, %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	(%rax), %ecx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x7, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x3001, %rcx          # imm = 0xCFFF
               	orq	$0x3000, %rcx           # imm = 0x3000
               	movw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xc001, %rcx          # imm = 0xFFFF3FFF
               	orq	$0x4000, %rcx           # imm = 0x4000
               	movw	%cx, (%rax)
               	movl	(%rax), %eax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	sarq	$0xc, %rdx
               	andq	$0x3, %rdx
               	shlq	$0x3e, %rdx
               	sarq	$0x3e, %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	sarq	$0xe, %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
