
libc_fp_return_value.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %eax
               	movsd	<rip>, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomisd	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	roundsd	$0x9, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomisd	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	roundsd	$0xa, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomisd	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm1
               	xorl	%ecx, %ecx
               	ucomisd	%xmm0, %xmm1
               	movq	%rax, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	xorl	%eax, %eax
               	ucomisd	%xmm1, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	movss	<rip>, %xmm0
               	sqrtss	%xmm0, %xmm0
               	movss	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomiss	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm1
               	xorl	%ecx, %ecx
               	ucomiss	%xmm0, %xmm1
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	sqrtss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomisd	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	roundss	$0x9, %xmm0, %xmm0
               	movss	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomiss	%xmm1, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	roundss	$0xa, %xmm0, %xmm0
               	movss	<rip>, %xmm1
               	xorl	%ecx, %ecx
               	ucomiss	%xmm1, %xmm0
               	movq	%rax, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
