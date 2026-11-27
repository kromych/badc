
libc_fp_return_value.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbx
               	movl	$0x1, %eax
               	movsd	<rip>, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	roundsd	$0x9, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	roundsd	$0xa, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movsd	<rip>, %xmm0
               	vandpd	<rip>, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	movss	<rip>, %xmm0
               	sqrtss	%xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomiss	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	vandpd	<rip>, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomiss	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	sqrtss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	roundss	$0x9, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomiss	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movss	<rip>, %xmm0
               	roundss	$0xa, %xmm0, %xmm0
               	xorl	%ecx, %ecx
               	ucomiss	<rip>, %xmm0
               	movq	%rax, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
