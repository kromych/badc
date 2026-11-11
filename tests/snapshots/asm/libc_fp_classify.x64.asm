
libc_fp_classify.x64:	file format elf64-x86-64

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
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x10(%rbp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	-0x8(%rbp), %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$-0x3ff8000000000000, %rcx # imm = 0xC008000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x10(%rbp), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movq	-0x8(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rsi
               	orq	%rsi, %rcx
               	movq	%rcx, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$-0x3fec000000000000, %rcx # imm = 0xC014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rcx
               	orq	%rcx, %rax
               	movq	%rax, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0xc0000000, %eax       # imm = 0xC0000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	-0x10(%rbp), %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	je	<addr>
               	movl	$0x7f800000, -0x8(%rbp) # imm = 0x7F800000
               	movl	-0x8(%rbp), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x17, %rdx
               	andq	$0xff, %rdx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	testl	%ecx, %ecx
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7fc00000, -0x8(%rbp) # imm = 0x7FC00000
               	movl	-0x8(%rbp), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x17, %rdx
               	andq	$0xff, %rdx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$0x12688b70e62b, %rax   # imm = 0x12688B70E62B
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %edx
               	jne	<addr>
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmoveq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %edx
               	jne	<addr>
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	movq	%rdx, %rcx
               	cmovneq	%rax, %rcx
               	jmp	<addr>
