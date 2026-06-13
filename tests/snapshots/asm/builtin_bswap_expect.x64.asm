
builtin_bswap_expect.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x200, %eax            # imm = 0x200
               	movl	$0x1, %ecx
               	orq	%rcx, %rax
               	cmpq	$0x201, %rax            # imm = 0x201
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4000000, %eax        # imm = 0x4000000
               	movl	$0x30000, %ecx          # imm = 0x30000
               	orq	%rcx, %rax
               	movl	$0x200, %ecx            # imm = 0x200
               	orq	%rcx, %rax
               	movl	$0x1, %ecx
               	orq	%rcx, %rax
               	cmpq	$0x4030201, %rax        # imm = 0x4030201
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x800000000000000, %rax # imm = 0x800000000000000
               	movabsq	$0x7000000000000, %rcx  # imm = 0x7000000000000
               	orq	%rcx, %rax
               	movabsq	$0x60000000000, %rcx    # imm = 0x60000000000
               	orq	%rcx, %rax
               	movabsq	$0x500000000, %rcx      # imm = 0x500000000
               	orq	%rcx, %rax
               	movl	$0x4000000, %ecx        # imm = 0x4000000
               	orq	%rcx, %rax
               	movl	$0x30000, %ecx          # imm = 0x30000
               	orq	%rcx, %rax
               	movl	$0x200, %ecx            # imm = 0x200
               	orq	%rcx, %rax
               	movl	$0x1, %ecx
               	orq	%rcx, %rax
               	movabsq	$0x807060504030201, %r13 # imm = 0x807060504030201
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xaabbccdd, %eax       # imm = 0xAABBCCDD
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movl	$0xddccbbaa, %r13d      # imm = 0xDDCCBBAA
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	cmpq	$0x5, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %rax
               	je	<addr>
               	ud2
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
